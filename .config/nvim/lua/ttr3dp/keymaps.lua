vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Leader><Space>', '<C-^>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0')
vim.keymap.set('n', '<Leader>so', function() vim.cmd.source(os.getenv('MYVIMRC')) end, { desc = 'Source config file' })
vim.keymap.set('n', '<Leader>ev', function() vim.cmd.edit(os.getenv('MYVIMRC')) end, { desc = 'Open config file' })
vim.keymap.set('c', '%%', function()
  if vim.fn.getcmdtype() == ':' then return vim.fn.expand('%:h') .. '/' else return '%%' end
end, { expr = true, desc = 'Expand current file dir in command mode' })
vim.keymap.set('v', '<C-r>', [["hy:%s/\V<C-r>h//g<left><left>]], { desc = 'Find and replace visual selection ocurrences in buffer' })
