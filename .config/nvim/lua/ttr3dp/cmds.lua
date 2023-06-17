-- Stolen from https://gitlab.com/obxhdx/dotfiles
vim.api.nvim_create_user_command('CloseOtherBuffers', function()
  local fn = vim.fn
  local all_buffers = fn.filter(fn.getbufinfo(), 'v:val.listed')
  local only_visible_buffers = fn.filter(all_buffers, 'empty(v:val.windows)')
  local buffer_numbers = fn.map(only_visible_buffers, 'v:val.bufnr')
  vim.cmd('bdelete ' .. fn.join(buffer_numbers))
end, {
  force = true,
  desc = 'close all buffers except the ones visible (including split or tabs)',
})

-- Stolen from https://github.com/r00k/dotfiles
-- Easily rename file and buffer
vim.api.nvim_create_user_command('RenameFile', function()
  local old = { path = vim.fn.expand('%:p'), name = vim.fn.expand('%') }
  local new_name = vim.fn.input({
    prompt = 'New file name: ',
    default = old.name,
    completion = 'file',
  })

  if new_name == '' or new_name == old.name then return end
  vim.cmd.saveas(new_name) -- save buffer under new name
  os.remove(old.name) -- remove old file
  for _, buf_nr in ipairs(vim.api.nvim_list_bufs()) do -- go through open bufs
    if vim.api.nvim_buf_get_name(buf_nr) == old.path then -- when old buf is found
      vim.api.nvim_buf_delete(buf_nr, { force = true }) -- delete
      break
    end
  end
  vim.cmd.redraw({ bang = true })
  print(string.format('Renamed %s -> %s', old.name, new_name)) -- print message
end, {
  force = true,
  desc = 'rename current file'
})

-- Get colors for kitty terminal based on the current colorscheme
vim.api.nvim_create_user_command('KittyColors', function()
  -- get Normal hl values
  local norm_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })

  local scheme = {
    'foreground #' .. string.format('%x', norm_hl.fg), -- fg
    'background #' .. string.format('%x', norm_hl.bg), -- bg
    '', -- empty line
  }

  -- for each of terminal_color_{i}
  for i = 0, 15, 1 do
    local row = { 'color', i, ' ', vim.g['terminal_color_' .. i] }
    table.insert(scheme, table.concat(row, '')) -- color terminal_color_{i}
  end
  table.insert(scheme, '') -- empty line at the end
  local curr_pos = vim.api.nvim_win_get_cursor(0) -- get current position

  -- insert above generated text on current position
  vim.api.nvim_buf_set_text(0, curr_pos[1], curr_pos[2], curr_pos[1], curr_pos[2], scheme)
end, {
  force = true,
  desc = 'spit out kitty terminal colors based on the current colorscheme'
})

local MyAutoCmds = vim.api.nvim_create_augroup('MyAutoCmds', {})
local aucmd = vim.api.nvim_create_autocmd

 -- Don't auto-wrap text using textwidth (-=t)
 -- Don't auto-wrap comments using textwidth (-=c)
 -- Don't insert comment leader automatically (-=c)
 -- Don't insert current comment leader after hitting <Enter> in Insert mode (-=r)
 -- Don't insert current comment leader after hitting 'o'/'O' in Normal mode (-=o)
aucmd({'FileType'}, { group = MyAutoCmds, pattern = '*', callback = function ()
  vim.opt.formatoptions = vim.opt.formatoptions - 't' - 'c' - 'r' - 'o'
end })

-- clear trailing whitespace on save
aucmd({'BufWritePre'}, { group = MyAutoCmds, pattern = '*', command = [[%s/\s\+$//e]] })

-- autowrite on certain events
aucmd({'CursorHold', 'BufLeave', 'FocusLost'}, { group = MyAutoCmds, pattern = '*', command = [[silent! wall]] })

-- highlight selection on yank
aucmd({'TextYankPost'}, { group = MyAutoCmds, pattern = '*', callback = function (_) vim.highlight.on_yank({timeout = 100}) end })

-- <Leader-p> inserts 'pry' breakpoint in ruby files
aucmd({'Filetype'}, { group = MyAutoCmds, pattern = 'ruby', callback = function (_)
    vim.keymap.set('n', '<leader>p', [[orequire "pry"; binding.pry<esc>]], { buffer = true, silent = true })
end })

-- <Leader-p> inserts 'psysh' breakpoint in php files
aucmd({'Filetype'}, { group = MyAutoCmds, pattern = 'php', callback = function (_)
    vim.keymap.set('n', '<leader>p', [[oeval(\Psy\sh());<esc>]], { buffer = true, silent = true })
end })

-- Bring me back to last known position when opening file
aucmd({'BufReadPost'}, { group = MyAutoCmds, pattern = '*', callback = function (_)
  if vim.opt.filetype.get == 'gitcommit' then return end
  if vim.fn.line("'\"") > 2 and vim.fn.line("'\"") <= vim.api.nvim_buf_line_count(0) then
    vim.cmd.normal('g`\"')
  end
end })

-- Open fold on current line when entering buffer
aucmd({'BufWinEnter'}, { group = MyAutoCmds, pattern = '*', callback = function ()
  if vim.fn.foldclosed('.') > -1 then vim.cmd.foldopen() end
end })
