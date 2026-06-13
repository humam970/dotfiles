local lsps = {
	-- biome = {
	-- 	cmd = { "biome", "lsp-proxy" },
	-- 	root_markers = { "biome.json", "biome.jsonc", "package.json", ".git" },
	-- 	settings = {
	-- 		formatter = {
	-- 			lineWidth = 120,
	-- 			indentWidth = 4,
	-- 		},
	-- 	},
	-- },

	just_ls = {
		cmd = { "just-lsp" },
		root_markers = { "justfile", ".git" },
	},

	-- pgls = {
	-- 	cmd = { "pgls", "lsp-proxy" },
	-- 	root_markers = { "postgres-language-server.jsonc", ".git" },
	-- },

	tinymist = {
		cmd = { "tinymist", "lsp" },
		root_markers = { "intro.typ", ".git" },
	},

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

		settings = {
			["rust-analyzer"] = {
				semanticHighlighting = {
					strings = {
						enable = false,
					},
				},
			},
		},
	},

	superhtml = {
		cmd = { "superhtml", "lsp" },
	},

	-- tailwind_ls = {
	-- 	cmd = { "tailwindcss-language-server", "--stdio" },
	-- 	root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" },
	-- 	settings = {
	-- 		tailwindCSS = {
	-- 			classFunctions = { "cva", "cx" },
	-- 		},
	-- 	},
	-- },

	-- ts_ls = {
	-- 	cmd = { "typescript-language-server", "--stdio" },
	-- 	root_markers = { "tsconfig.json", "package.json", ".git" },
	-- 	settings = {
	-- 		javascript = {
	-- 			format = { enable = false },
	-- 		},
	-- 		typescript = {
	-- 			format = { enable = false },
	-- 		},
	-- 	},
	-- },

	yaml_ls = {
		cmd = { "yaml-language-server", "--stdio" },
	},

	-- css_ls = {
	-- 	cmd = { "vscode-css-language-server", "--stdio" },
	-- },
}

local filetypes_config = {
	html = { "superhtml" },
	-- json = { "biome" },
	-- css = { "css_ls" },

	-- javascript = { "ts_ls", "biome", "tailwind_ls" },
	-- typescript = { "ts_ls", "biome", "tailwind_ls" },
	--
	-- javascriptreact = { "ts_ls", "biome", "tailwind_ls" },
	-- typescriptreact = { "ts_ls", "biome", "tailwind_ls" },

	c = { "clangd" },

	cpp = { "clangd" },

	rust = { "rust_ls" },

	yaml = { "yaml_ls" },

	go = { "gopls" },
	gomod = { "gopls" },
	-- sql = { "pgls" },

	lua = { "lua_ls" },

	just = { "just_ls" },

	typst = { "tinymist" },
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
	update_in_insert = false,
})

local fzf = require("fzf-lua")
local mappings = {
	{
		method = "textDocument/implementation",
		mode = "n",
		lhs = "gi",
		rhs = fzf.lsp_implementations,
	},
	{
		method = "textDocument/codeAction",
		mode = { "n", "v" },
		lhs = "ga",
		rhs = fzf.lsp_code_actions,
	},
	{
		method = "textDocument/declaration",
		mode = "n",
		lhs = "gD",
		rhs = fzf.lsp_declarations,
	},
	{
		method = "textDocument/definition",
		mode = "n",
		lhs = "gd",
		rhs = fzf.lsp_definitions,
	},
	{
		method = "textDocument/typeDefinition",
		mode = "n",
		lhs = "gt",
		rhs = fzf.lsp_typedefs,
	},
	{
		method = "textDocument/references",
		mode = "n",
		lhs = "gR",
		rhs = fzf.lsp_references,
	},
	{
		method = "textDocument/documentSymbol",
		mode = "n",
		lhs = "gO",
		rhs = fzf.lsp_document_symbols,
	},
	{
		method = "workspace/symbol",
		mode = "n",
		lhs = "gW",
		rhs = fzf.lsp_workspace_symbols,
	},
	{
		method = "textDocument/rename",
		mode = "n",
		lhs = "grn",
		rhs = vim.lsp.buf.rename,
	},
	{
		method = "textDocument/hover",
		mode = "n",
		lhs = "gk",
		rhs = function()
			vim.lsp.buf.hover({
				border = "solid",
				focusable = true,
			})
		end,
	},
	{
		method = "textDocument/signatureHelp",
		mode = "n",
		lhs = "gs",
		rhs = function()
			vim.lsp.buf.signature_help({
				border = "solid",
				focusable = false,
			})
		end,
	},
}

local lspgroup = vim.api.nvim_create_augroup("lspgroup", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lspgroup,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		for _, mapping in ipairs(mappings) do
			if client:supports_method(mapping.method) then
				vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, {
					buffer = args.buf,
					silent = true,
				})
			end
		end
	end,
})
