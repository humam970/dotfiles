for i = 1, 9 do
	vim.keymap.set("n", "<C-" .. i .. ">", i .. "gt")
end

vim.keymap.set("n", "<C-t>", function()
	if #vim.api.nvim_list_tabpages() < 9 then
		vim.cmd.tabnew()
	end
end)

vim.keymap.set("n", "<C-q>", function()
	local tab = vim.api.nvim_get_current_tabpage()
	local wins = vim.api.nvim_tabpage_list_wins(tab)

	for _, win in ipairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].modified then
			vim.notify("Cannot close tab with unsaved changes.", vim.log.levels.WARN)
			return
		end
	end

	vim.cmd.tabclose()
end)

vim.keymap.set("n", "t", "<Nop>")

vim.keymap.set("n", "<C-n>", vim.cmd.cnext)
vim.keymap.set("n", "<C-p>", vim.cmd.cprev)

vim.keymap.set("n", "U", vim.cmd.redo)

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>")

vim.keymap.set("n", "0", "_")

vim.keymap.set({ "n", "v", "x" }, "J", function()
	vim.cmd.normal("20jzz")
end)
vim.keymap.set({ "n", "v", "x" }, "K", function()
	vim.cmd.normal("20kzz")
end)

vim.keymap.set({ "n", "v", "x" }, "L", "g_")
vim.keymap.set({ "n", "v", "x" }, "H", "_")

-- vim.api.nvim_get_current_win()
-- vim.api.nvim_get_current_tabpage()
-- vim.api.nvim_win_get_tabpage({win})
-- vim.api.nvim_win_get_tabpage()

vim.keymap.set("n", "<C-j>", function()
	vim.cmd.wincmd("j")
end)
vim.keymap.set("n", "<C-k>", function()
	vim.cmd.wincmd("k")
end)
vim.keymap.set("n", "<C-l>", function()
	vim.cmd.wincmd("l")
end)
vim.keymap.set("n", "<C-h>", function()
	vim.cmd.wincmd("h")
end)

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")

vim.keymap.set("n", "gh", vim.cmd.nohl, { silent = true })
vim.keymap.set({ "n", "v", "x" }, "m", "%")

vim.keymap.set("n", "<leader>y", ":%y<CR>")
-- vim.keymap.set("n", "gf", ":vertical botright wincmd f<CR>")

vim.keymap.set("n", "ge", function()
	vim.diagnostic.open_float({
		focusable = true,
		source = "if_many",
		header = "",
	})
end)
