vim.opt.formatoptions:remove("o")
vim.opt.clipboard:append("unnamedplus")
vim.opt.shortmess:append("sI")
vim.opt.shada = { "'10", "<0", "s10", "h" }

vim.o.number = true
vim.o.relativenumber = true
vim.o.statusline = [[[%n] %<%f  %h%w%m%r%=%-14.(%l,%c%V%) %P]]
vim.o.mouse = ""
vim.o.inccommand = "split"
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.incsearch = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.smoothscroll = true
vim.o.completeopt = "menu,menuone,fuzzy,noinsert"
vim.o.more = false
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
vim.o.tabpagemax = 9

vim.o.timeout = false
vim.o.timeoutlen = 250
