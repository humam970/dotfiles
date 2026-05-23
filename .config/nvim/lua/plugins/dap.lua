vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/igorlfs/nvim-dap-view",

	-- Depends on nvim-treesitter/nvim-treesitter
	"https://github.com/leoluz/nvim-dap-go",
})

local dap = require("dap")
require("dap-go").setup()

local dap_view = require("dap-view")
dap_view.setup({
	winbar = {
		show = true,
		show_keymap_hints = true,
	},
	windows = {
		size = 0.43,
		position = "right",
		terminal = {
			size = 0.5,
			position = "left",
			hide = {},
		},
	},
	follow_tab = false,
})

vim.keymap.set("n", "go", dap_view.toggle)
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F10>", dap.restart)
