vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.10.2",
	},
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = false,
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		menu = {
			auto_show = false,
			draw = {
				columns = {
					{ "label", "label_description", gap = 3 },
					{ "kind_icon", "kind" },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "buffer" },
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning",
		sorts = {
			"sort_text",
			"score",
		},
	},
	signature = { enabled = true },
})
