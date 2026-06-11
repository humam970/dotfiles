vim.g.mapleader = " "

vim.cmd("syntax off")

vim.filetype.add({
	extension = {
		env = "dosini",
	},
	pattern = {
		[".env.*"] = "dosini",
	},
})

-- plugins
vim.cmd.packadd("nvim.difftool")
require("vim._core.ui2").enable({})
require("plugins.syntax_highlighting")
require("plugins.auto_complete")
require("plugins.colorscheme")
require("plugins.comfylines")
require("plugins.formatting")
require("plugins.gitsigns")
require("plugins.compile")
require("plugins.mini")
require("plugins.lsp")
require("plugins.dap")

-- autocmds
require("autocmds")
