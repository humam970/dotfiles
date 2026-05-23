local lsps = {
	biome = {
		cmd = { "biome", "lsp-proxy" },
		root_markers = { "biome.json", "biome.jsonc", "package.json", ".git" },
		settings = {
			formatter = {
				lineWidth = 120,
				indentWidth = 4,
			},
		},
	},

	just_ls = {
		cmd = { "just-lsp" },
		root_markers = { "justfile", ".git" },
	},

	elixir_ls = {
		cmd = { "/home/humam/elixir/language_server.sh" },
		root_markers = { "mix.exs", ".git" },
	},

	pgls = {
		cmd = { "pgls", "lsp-proxy" },
		root_markers = { "postgres-language-server.jsonc", ".git" },
	},

	-- eslint = {
	-- 	cmd = { "eslint-language-server", "--stdio" },
	-- 	root_markers = { "eslint.config.js", "package.json", ".git" },
	-- },

	clangd = {
		cmd = { "clangd" },
		root_markers = {
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git",
		},
	},

	golint = {
		cmd = { "golangci-lint-langserver" },
		root_markers = { ".golangci.yml", ".golangci.yaml", "go.mod", "go.work", ".git" },
	},

	gopls = {
		cmd = { "gopls" },
		root_markers = { "go.mod", "go.work", ".git" },
	},

	lua_ls = {
		cmd = { "lua-language-server" },
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		},
	},

	rust_ls = {
		cmd = { "rust-analyzer" },
		root_markers = { "Cargo.lock", "Cargo.toml", ".git" },
	},

	superhtml = {
		cmd = { "superhtml", "lsp" },
	},

	tailwind_ls = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" },
		settings = {
			tailwindCSS = {
				classFunctions = { "cva", "cx" },
			},
		},
	},

	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		root_markers = { "tsconfig.json", "package.json", ".git" },
		settings = {
			javascript = {
				format = { enable = false },
			},
			typescript = {
				format = { enable = false },
			},
		},
	},

	yaml_ls = {
		cmd = { "yaml-language-server", "--stdio" },
	},

	css_ls = {
		cmd = { "vscode-css-language-server", "--stdio" },
	},
}

local filetypes_config = {
	json = { "biome" },
	html = { "superhtml" },
	css = { "css_ls" },

	javascript = { "ts_ls", "biome", "tailwind_ls" },
	typescript = { "ts_ls", "biome", "tailwind_ls" },

	javascriptreact = { "ts_ls", "biome", "tailwind_ls" },
	typescriptreact = { "ts_ls", "biome", "tailwind_ls" },

	c = { "clangd" },

	cpp = { "clangd" },

	rust = { "rust_ls" },

	yaml = { "yaml_ls" },

	go = { "gopls" },
	gomod = { "gopls" },
	-- elixir = { "elixir_ls" },

	-- sql = { "pgls" },

	lua = { "lua_ls" },

	just = { "just_ls" },
}

local function create_final_config(ft_cfg, source_lsps)
	local final = {}

	for name, config in pairs(source_lsps) do
		final[name] = vim.deepcopy(config)
		final[name].filetypes = {}
	end

	for ft_key, names in pairs(ft_cfg) do
		local fts = type(ft_key) == "table" and ft_key or { ft_key }

		for _, ft in ipairs(fts) do
			if type(ft) == "string" then
				for _, name in ipairs(names) do
					if final[name] then
						table.insert(final[name].filetypes, ft)
					end
				end
			end
		end
	end

	return final
end

local final_lsps = create_final_config(filetypes_config, lsps)

for name, config in pairs(final_lsps) do
	vim.lsp.config(name, {
		cmd = config.cmd,
		root_markers = config.root_markers,
		settings = config.settings,
		filetypes = config.filetypes,
	})
end

vim.lsp.enable(vim.tbl_keys(final_lsps))

vim.diagnostic.config({
	update_in_insert = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lspgroup", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		local function set_lsp_keymap(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = args.buf
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		if client:supports_method("textDocument/implementation") then
			set_lsp_keymap("n", "gi", vim.lsp.buf.implementation)
		end

		if client:supports_method("textDocument/codeAction") then
			set_lsp_keymap({ "n", "v" }, "ga", vim.lsp.buf.code_action)
		end

		if client:supports_method("textDocument/declaration") then
			set_lsp_keymap("n", "gD", vim.lsp.buf.declaration)
		end

		if client:supports_method("textDocument/definition") then
			set_lsp_keymap("n", "gd", vim.lsp.buf.definition)
		end

		if client:supports_method("textDocument/typeDefinition") then
			set_lsp_keymap("n", "gt", vim.lsp.buf.type_definition)
		end

		if client:supports_method("textDocument/references") then
			set_lsp_keymap("n", "gR", vim.lsp.buf.references)
		end

		if client:supports_method("textDocument/hover") then
			set_lsp_keymap("n", "gk", function()
				vim.lsp.buf.hover({
					border = "solid",
					focusable = true,
				})
			end)
		end

		if client:supports_method("textDocument/signatureHelp") then
			set_lsp_keymap("n", "gs", function()
				vim.lsp.buf.signature_help({
					border = "solid",
					focusable = false,
				})
			end)
		end
	end,
})
