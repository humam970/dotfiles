vim.opt.formatoptions:remove("o")
vim.opt.clipboard:append("unnamedplus")
vim.opt.shortmess:append("sI")
vim.opt.shada = { "'10", "<0", "s10", "h" }

vim.opt.scrolloff = math.floor(vim.o.lines / 2) - 3

vim.o.wrap = false
vim.o.number = true
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.relativenumber = true

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.winborder = "solid"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.mouse = ""
vim.o.termguicolors = true
vim.o.smoothscroll = true
vim.o.completeopt = "menu,menuone,fuzzy,noinsert"
vim.o.more = false
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
vim.o.tabpagemax = 9

vim.o.timeout = false
vim.o.timeoutlen = 250
