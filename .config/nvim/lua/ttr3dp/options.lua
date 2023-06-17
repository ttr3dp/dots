vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.breakindent = true
vim.opt.autowrite = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '81'
vim.opt.completeopt = 'menuone'
vim.opt.cursorline = true
vim.opt.diffopt = { 'internal', 'filler', 'closeoff', 'vertical' }
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 3
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2

vim.cmd([[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]])
vim.cmd([[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]])
vim.opt.termguicolors = true

vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.updatetime = 50
vim.opt.fillchars = { eob = ' ' }
vim.opt.listchars = { tab = '»·', trail = '•', nbsp = '·',  }
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.is_posix = 1
