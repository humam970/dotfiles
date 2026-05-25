vim.opt.number = true
vim.opt.relativenumber = true
vim.o.grepprg = "rg --vimgrep --smart-case --glob '!target/*' --glob '!.git/*'"
vim.o.grepformat = "%f:%l:%c:%m"
vim.opt.statusline = [[[%n] %<%f  %h%w%m%r%=%-14.(%l,%c%V%) %P]]
vim.opt.mouse = ""
vim.opt.timeoutlen = 300
vim.opt.inccommand = "split"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.swapfile = false
vim.opt.formatoptions:remove("o")
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.shortmess:append("sI")
vim.opt.smoothscroll = true
vim.opt.completeopt = "menu,menuone,fuzzy,noinsert"
vim.opt.more = false
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
