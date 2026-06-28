local core_augroup = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

-- Autocommand to check git status
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Verify if the current directory is a git repo
		local is_git = os.execute("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
		if is_git ~= 0 then
			return
		end

		-- Perform an async fetch to avoid startup lag
		vim.fn.jobstart("git fetch", {
			on_exit = function()
				-- Get the number of commits the remote is ahead of local HEAD
				local count = vim.fn.system("git rev-list --count HEAD..@{u} 2>/dev/null"):gsub("%s+", "")

				if count ~= "" and tonumber(count) > 0 then
					vim.schedule(function()
						vim.notify(
							"󰊢 " .. count .. " new commit(s) available on remote.",
							vim.log.levels.INFO,
							{ title = "Git Status", icon = "󰊢" }
						)
					end)
				end
			end,
		})
	end,
})

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
