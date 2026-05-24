for i = 1, 9 do
	vim.keymap.set("n", "<C-" .. i .. ">", i .. "gt")
end

vim.keymap.set("n", "<C-t>", function()
	if #vim.api.nvim_list_tabpages() < 9 then
		vim.cmd("tabnew")
	end
end)

vim.keymap.set("n", "<C-q>", "<Cmd>tabclose<CR>")

vim.keymap.set("n", "<leader>s", "<cmd>source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "t", "<Nop>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>")

vim.keymap.set("n", "0", "_")

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

local function flash_move(cmd)
	local highlight_group = "IncSearch"
	local timeout = 250

	local bufnr = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1

	local ns_id = vim.api.nvim_create_namespace("flash_move")

	vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, 0, {
		end_row = row + 1,
		hl_group = highlight_group,
		hl_eol = true,
	})

	vim.cmd("normal! " .. cmd)

	vim.defer_fn(function()
		if vim.api.nvim_buf_is_valid(bufnr) then
			vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
		end
	end, timeout)
end

vim.keymap.set({ "n", "v", "x" }, "J", function()
	flash_move("zt25j")
end)

vim.keymap.set({ "n", "v", "x" }, "K", function()
	flash_move("zb25k")
end)

-- vim.keymap.set({ "n", "v", "x" }, "J", "<C-d>")
-- vim.keymap.set({ "n", "v", "x" }, "K", "<C-u>")
vim.keymap.set({ "n", "v", "x" }, "L", "g_")
vim.keymap.set({ "n", "v", "x" }, "H", "_")

vim.keymap.set("n", "<C-j>", "<c-w><c-j>")
vim.keymap.set("n", "<C-k>", "<c-w><c-k>")
vim.keymap.set("n", "<C-l>", "<c-w><c-l>")
vim.keymap.set("n", "<C-h>", "<c-w><c-h>")

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")

vim.keymap.set("n", "<leader>h", ":nohl<CR>")
vim.keymap.set({ "n", "v", "x" }, "m", "%")

vim.keymap.set("n", "<leader>y", ":%y<CR>")
vim.keymap.set("n", "gf", ":vertical botright wincmd f<CR>", { desc = "Go to file in full-height vsplit" })

vim.keymap.set("n", "ge", function()
	vim.diagnostic.open_float({
		focusable = true,
		border = "solid",
		source = "if_many",
		header = "",
	})
end)
