vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 2
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
require('ttr3dp.options')
require('ttr3dp.keymaps')
require('ttr3dp.plugins')
require('ttr3dp.cmds')

-- vim.cmd.colorscheme('retrobox')
-- vim.cmd.highlight([[Normal guibg=#1f2329]])
-- vim.cmd.highlight([[NormalNC guibg=#1f2329]])
-- vim.cmd.highlight([[SignColumn guibg=#1f2329]])
-- vim.cmd.highlight([[CursorLine guibg=#131519]])
-- vim.cmd.highlight([[CursorLineNr guibg=#131519]])
-- vim.cmd.highlight([[ColorColumn guibg=#131519]])
-- vim.cmd.highlight([[StatusLine guibg=#1c1c1c guifg=#83a598]])

local fm = require 'fluoromachine'

fm.setup {
  glow = false,
  theme = 'retrowave',
  transparent = 'full',
}

vim.cmd.colorscheme('fluoromachine')

vim.cmd.highlight([[CursorLine guibg=#15131f]])
vim.cmd.highlight([[ColorColumn guibg=#15131f]])
