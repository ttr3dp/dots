vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_automap_keys = ',tt'
vim.g.neoterm_autoscroll = 1

vim.keymap.set('t', '<C-Space>', '<C-\\><C-n>', { silent = true })
vim.keymap.set('n',  ',to', ':Topen<cr>', { silent = true })
vim.keymap.set('n',  ',tc', ':Tclose<cr>',{ silent = true })
vim.keymap.set('n',  ',tl', ':Tclear<cr>',{ silent = true })
vim.keymap.set('n',  ',tk', ':Tkill<cr>', { silent = true })
vim.keymap.set('n',  '<leader>ri', ':T <right>')
