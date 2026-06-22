vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/neanias/everforest-nvim",
	"https://github.com/tiagovla/tokyodark.nvim",
	"https://github.com/shaunsingh/nord.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/catppuccin/nvim",
})

require("kanagawa").setup({
	colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
})

require("everforest").setup({
	background = "hard",
	ui_contrast = "high",
	show_eob = false,
})

vim.cmd.colorscheme("everforest")
