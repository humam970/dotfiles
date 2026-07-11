vim.pack.add({
	{
		src = "https://github.com/echasnovski/mini.pairs",
		version = "stable",
	},
	{
		src = "https://github.com/nvim-mini/mini.icons",
		version = "stable",
	},
	{
		src = "https://github.com/echasnovski/mini.files",
		version = "stable",
	},
})

require("mini.pairs").setup()
require("mini.icons").setup()
local mini_files = require("mini.files")

mini_files.setup({
	mappings = {
		go_in = "",
		go_out = "",

		go_in_plus = "",
		go_out_plus = "",

		mark_goto = "",
		mark_set = "",
		reveal_cwd = "",
	},

	options = {
		permanent_delete = false,
	},

	windows = {
		preview = true,
	},
})

do
	mini_files.layout = {}

	local enums = { "nofocus", "preview" }
	for _, e in ipairs(enums) do
		mini_files.layout[e] = false
	end
end

local set_layout = function(opts)
	opts = opts or {}

	local layout = mini_files.layout

	layout.nofocus = opts.nofocus ~= nil and opts.nofocus or layout.nofocus
	layout.preview = opts.preview ~= nil and opts.preview or layout.preview
end

local get_windows_opts = function()
	local total_width = vim.o.columns
	local layout = mini_files.layout

	local R = {
		max_number = 1,
		preview = false,
		width_focus = math.floor(total_width * 0.28),
	}

	if layout.nofocus then
		R.width_nofocus = math.floor(total_width * 0.28)
		R.max_number = R.max_number + 1
	end

	if layout.preview then
		R.preview = true
		R.max_number = R.max_number + 1

		local used_width = R.width_focus
		if layout.nofocus then
			used_width = used_width + R.width_nofocus
		end

		R.width_preview = math.max(20, total_width - used_width - 4)
	end

	return R
end

-- default layout
set_layout({ preview = true })

vim.keymap.set("n", "<leader>e", function()
	if mini_files.close() then
		return
	end

	mini_files.open(vim.api.nvim_buf_get_name(0), nil, {
		windows = get_windows_opts(),
	})
end)

vim.keymap.set("n", "<leader>E", function()
	if mini_files.close() then
		return
	end

	mini_files.open(nil, false, {
		windows = get_windows_opts(),
	})
end)

local is_entry_type = function(type)
	local entry = mini_files.get_fs_entry()
	return entry and entry.fs_type == type
end

local minifiles_augroup = vim.api.nvim_create_augroup("minifiles_keymaps", { clear = true })

vim.api.nvim_create_autocmd("User", {
	group = minifiles_augroup,
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id

		vim.keymap.set("n", "l", function()
			if is_entry_type("directory") then
				mini_files.go_in()
			end
		end, { buffer = buf_id })

		vim.keymap.set("n", "h", function()
			mini_files.go_out()
			mini_files.trim_right()
		end, { buffer = buf_id })

		vim.keymap.set("n", "<CR>", function()
			if is_entry_type("file") then
				mini_files.go_in({ close_on_file = true })
			end
		end, { buffer = buf_id })

		vim.keymap.set("n", "<C-p>", function()
			mini_files.layout.preview = not mini_files.layout.preview

			mini_files.trim_right()
			mini_files.refresh({
				windows = get_windows_opts(),
			})
		end, { buffer = buf_id })
	end,
})

local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		if not is_entry_type("file") then
			return
		end

		local cur_target = mini_files.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)

		mini_files.set_target_window(new_target)
		mini_files.go_in({ close_on_file = true })
	end

	vim.keymap.set("n", lhs, rhs, { buffer = buf_id })
end

vim.api.nvim_create_autocmd("User", {
	group = minifiles_augroup,
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		map_split(buf_id, "<C-s>", "vertical")
		map_split(buf_id, "<C-t>", "tab")
	end,
})
