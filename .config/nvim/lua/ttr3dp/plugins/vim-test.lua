vim.g['test#strategy'] = 'neoterm'

vim.keymap.set('n', '<leader>rt', ':TestNearest<CR>',  { silent = true })
vim.keymap.set('n', '<leader>rf', ':TestFile<CR>',     { silent = true })
vim.keymap.set('n', '<leader>ra', ':TestSuite<CR>',    { silent = true })
vim.keymap.set('n', '<leader>rl', ':TestLast<CR>' ,    { silent = true })
vim.keymap.set('n', '<leader>rg', ':TestVisit<CR>',    { silent = true })
