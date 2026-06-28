vim.pack.add({
	"https://github.com/ej-shafran/compile-mode.nvim",

	-- Dependencies
	"https://github.com/nvim-lua/plenary.nvim",
})

vim.g.compile_mode = {
	default_command = {
		rust = "",
		go = "",
	},
}

vim.keymap.set("n", "<leader>c", ":Compile<CR>")
