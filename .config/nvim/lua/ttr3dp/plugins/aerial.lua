require('aerial').setup({
  layout = {
    default_direction = "prefer_right",
    placement = "window",
  }
})

vim.keymap.set('n', '<leader>a', vim.cmd.AerialToggle)
