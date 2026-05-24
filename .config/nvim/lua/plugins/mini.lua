---@diagnostic disable: unused-local, unused-function
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

local set_focus_window_width = function()
	local win_config = mini_files.config.windows
	local total_width = vim.o.columns
	win_config.width_focus = math.floor(total_width * 0.30)
end

local set_preview_window_width = function()
	local win_config = mini_files.config.windows
	local total_width = vim.o.columns
	win_config.width_preview = total_width - win_config.width_focus - 4
end

local set_max_windows = function()
	local win_config = mini_files.config.windows
	win_config.max_number = win_config.preview and 2 or 1
end

vim.keymap.set("n", "<leader>e", function()
	if mini_files.close() then
		return
	end

	set_focus_window_width()
	set_max_windows()

	if mini_files.config.windows.preview then
		set_preview_window_width()
	end

	mini_files.open()
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
		end, { buffer = buf_id })

		vim.keymap.set("n", "<CR>", function()
			if is_entry_type("file") then
				mini_files.go_in({ close_on_file = true })
			end
		end, { buffer = buf_id })

		-- toggle preview
		-- vim.keymap.set("n", "<C-p>", function()
		-- 	local win_config = mini_files.config.windows
		--
		-- 	win_config.preview = not win_config.preview
		-- 	set_max_windows()
		--
		-- 	if not win_config.preview then
		-- 		mini_files.refresh()
		-- 	else
		-- 		set_preview_window_width()
		-- 		mini_files.refresh()
		-- 	end
		-- end, { buffer = buf_id })
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
