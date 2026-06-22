local core_augroup = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
	group = core_augroup,
	callback = function()
		vim.cmd.clearjumps()
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = core_augroup,
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

-- Restore cursor to last position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = core_augroup,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = core_augroup,
	pattern = "help",
	command = "wincmd L",
})

vim.api.nvim_create_autocmd("VimResized", {
	group = core_augroup,
	command = "wincmd =",
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = core_augroup,
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
