vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

local lsps = {
	"lua_ls",
	"gopls",
	"golangci_lint_ls",
	-- "rust-analyzer",
}

for _, lsp in ipairs(lsps) do
	vim.lsp.enable(lsp)
end

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
