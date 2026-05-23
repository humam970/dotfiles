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
		max_number = 2,
		preview = true,
		width_focus = 25,
		-- Width of non-focused window
		width_nofocus = 25,
		-- Width of preview window
		width_preview = 50,
	},
})

vim.keymap.set("n", "<leader>e", function()
	if not mini_files.close() then
		mini_files.open()
	end
end)

local is_entry_type = function(type)
	local entry = mini_files.get_fs_entry()
	return entry and entry.fs_type == type
end

local minifiles_augroup = vim.api.nvim_create_augroup("minifiles_keymaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = minifiles_augroup,
	pattern = "minifiles",
	callback = function(ev)
		vim.keymap.set("n", "l", function()
			if is_entry_type("directory") then
				mini_files.go_in()
			end
		end, { buffer = ev.buf })

		vim.keymap.set("n", "h", function()
			mini_files.go_out()
		end, { buffer = ev.buf })

		vim.keymap.set("n", "<CR>", function()
			if is_entry_type("file") then
				mini_files.go_in({ close_on_file = true })
			end
		end, { buffer = ev.buf })
	end,
})
