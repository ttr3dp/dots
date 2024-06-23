--  [[ OPTIONS ]]  {{{
vim.g.mapleader = ' '
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.wildmenu = true
vim.opt.listchars = {
  -- eol = '↲',
  tab = '» ',
  trail = '·',
  extends = '<',
  precedes = '>',
  conceal = '┊',
  nbsp = '␣'
}
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.path:append({ '.', '**' })

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

vim.cmd [[ set grepprg=rg\ --vimgrep\ --hidden ]]
vim.cmd [[ set grepformat^=%f:%l:%c:%m ]]

vim.cmd [[ filetype plugin on ]]
-- }}}

--  [[ PLUGINS ]]  {{{
require('vim-plug').add({
  'tpope/vim-sleuth',

  -- git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'junegunn/gv.vim',

  -- quality of life
  'ibhagwan/fzf-lua',
  'kylechui/nvim-surround',
  { 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } },

  -- testing
  'janko-m/vim-test',

  -- terminal
  'kassio/neoterm',

  -- markdown
  {
    'iamcco/markdown-preview.nvim',
    [[ { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} ]]
  },

  -- icon picker
  'stevearc/dressing.nvim',
  'ziontee113/icon-picker.nvim',

  -- file browser
  'stevearc/oil.nvim',

  -- LSP
  'j-hui/fidget.nvim',
  'neovim/nvim-lspconfig',
  'folke/neodev.nvim',
  'b0o/SchemaStore.nvim',

  'stevearc/aerial.nvim',

  -- completion
  'hrsh7th/nvim-cmp',
  'onsails/lspkind.nvim',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  { "L3MON4D3/LuaSnip",                { ['do'] = 'make install_jsregexp' } },
  "saadparwaiz1/cmp_luasnip",

  -- colors
  'norcalli/nvim-colorizer.lua',
  'navarasu/onedark.nvim'
})

vim.cmd [[ packadd! matchit ]]
-- }}}

--  [[ KEYMAPS ]]  {{{
vim.keymap.set('n', '<Leader><cr>', vim.cmd.nohlsearch, { desc = 'Clear search highlighting' })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set('n', '<Leader>so', function() vim.cmd.source(os.getenv('MYVIMRC')) end, { desc = 'Source config file' })
-- vim.keymap.set('n', '<Leader>ev', function() vim.cmd.edit(os.getenv('MYVIMRC')) end, { desc = 'Open config file' })
-- vim.keymap.set('c', '%%', function()
--   if vim.fn.getcmdtype() == ':' then return vim.fn.expand('%:h') .. '/' else return '%%' end
-- end, { expr = true, desc = 'Expand current file dir in command mode' })
vim.keymap.set('v', '<C-r>', [["hy:%s/\V<C-r>h//g<left><left>]],
  { desc = 'Find and replace visual selection ocurrences in buffer' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float) -- doesn't seem to do anything (need to investigate)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- }}}

--  [[ AUTOCMDS ]] {{{
-- Close Other Buffers {{{
-- Stolen from https://gitlab.com/obxhdx/dotfiles
vim.api.nvim_create_user_command('CloseOtherBuffers', function()
  local fn = vim.fn
  local all_buffers = fn.filter(fn.getbufinfo(), 'v:val.listed')
  local only_visible_buffers = fn.filter(all_buffers, 'empty(v:val.windows)')
  local buffer_numbers = fn.map(only_visible_buffers, 'v:val.bufnr')
  vim.cmd('bdelete! ' .. fn.join(buffer_numbers))
end, {
  force = true,
  desc = 'close all buffers except the ones visible (including split or tabs)',
})
-- }}}

-- Rename File {{{
-- Stolen from https://github.com/r00k/dotfiles
vim.api.nvim_create_user_command('RenameFile', function()
  local old = { path = vim.fn.expand('%:p'), name = vim.fn.expand('%') }
  local new_name = vim.fn.input({
    prompt = 'New file name: ',
    default = old.name,
    completion = 'file',
  })

  if new_name == '' or new_name == old.name then return end
  vim.cmd.saveas(new_name)                                -- save buffer under new name
  os.remove(old.name)                                     -- remove old file
  for _, buf_nr in ipairs(vim.api.nvim_list_bufs()) do    -- go through open bufs
    if vim.api.nvim_buf_get_name(buf_nr) == old.path then -- when old buf is found
      vim.api.nvim_buf_delete(buf_nr, { force = true })   -- delete
      break
    end
  end
  vim.cmd.redraw({ bang = true })
  print(string.format('Renamed %s -> %s', old.name, new_name)) -- print message
end, {
  force = true,
  desc = 'rename current file'
})
-- }}}

-- Generate Kitty (terminal) colors {{{
-- Get colors for kitty terminal based on the current colorscheme
vim.api.nvim_create_user_command('KittyColors', function()
  -- get Normal hl values
  local norm_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })

  local scheme = {
    'foreground #' .. string.format('%x', norm_hl.fg), -- fg
    'background #' .. string.format('%x', norm_hl.bg), -- bg
    '',                                                -- empty line
  }

  -- for each of terminal_color_{i}
  for i = 0, 15, 1 do
    local row = { 'color', i, ' ', vim.g['terminal_color_' .. i] }
    table.insert(scheme, table.concat(row, ''))   -- color terminal_color_{i}
  end
  table.insert(scheme, '')                        -- empty line at the end
  local curr_pos = vim.api.nvim_win_get_cursor(0) -- get current position

  -- insert above generated text on current position
  vim.api.nvim_buf_set_text(0, curr_pos[1], curr_pos[2], curr_pos[1], curr_pos[2], scheme)
end, {
  force = true,
  desc = 'spit out kitty terminal colors based on the current colorscheme'
})
-- }}}

local MyAutoCmds = vim.api.nvim_create_augroup('MyAutoCmds', {})
local aucmd = vim.api.nvim_create_autocmd

-- Format options (prevent bunch of stuff) {{{
-- Don't auto-wrap text using textwidth (-=t)
-- Don't auto-wrap comments using textwidth (-=c)
-- Don't insert comment leader automatically (-=c)
-- Don't insert current comment leader after hitting <Enter> in Insert mode (-=r)
-- Don't insert current comment leader after hitting 'o'/'O' in Normal mode (-=o)
aucmd({ 'FileType' }, {
  group = MyAutoCmds,
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - 't' - 'c' - 'r' - 'o'
  end
})
-- }}}

-- Clear trailing whitespace on save {{{
aucmd({ 'BufWritePre' }, { group = MyAutoCmds, pattern = '*', command = [[%s/\s\+$//e]] })
-- }}}

-- Autowrite on certain events {{{
aucmd({ 'CursorHold', 'BufLeave', 'FocusLost' }, { group = MyAutoCmds, pattern = '*', command = [[silent! wall]] })
-- }}}

-- Highlight selection on yank {{{
aucmd({ 'TextYankPost' },
  { group = MyAutoCmds, pattern = '*', callback = function(_) vim.highlight.on_yank({ timeout = 100 }) end })
-- }}}

-- <Leader-p> inserts 'pry' breakpoint in ruby files {{{
aucmd({ 'Filetype' }, {
  group = MyAutoCmds,
  pattern = 'ruby',
  callback = function(_)
    vim.keymap.set('n', '<leader>p', [[orequire "pry"; binding.pry<esc>]], { buffer = true, silent = true })
  end
})
-- }}}

-- <Leader-p> inserts 'psysh' breakpoint in php files {{{
aucmd({ 'Filetype' }, {
  group = MyAutoCmds,
  pattern = 'php',
  callback = function(_)
    vim.keymap.set('n', '<leader>p', [[oeval(\Psy\sh());<esc>]], { buffer = true, silent = true })
  end
})
-- }}}

-- fold JSON  {{{
aucmd({ 'Filetype' }, {
  group = MyAutoCmds,
  pattern = 'json',
  callback = function(_)
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end
})


-- }}}

-- Bring me back to last known position when opening file {{{
aucmd({ 'BufReadPost' }, {
  group = MyAutoCmds,
  pattern = '*',
  callback = function(_)
    if vim.opt.filetype.get == 'gitcommit' then return end
    if vim.fn.line("'\"") > 2 and vim.fn.line("'\"") <= vim.api.nvim_buf_line_count(0) then
      vim.cmd.normal('g`\"')
    end
  end
})
-- }}}
-- }}}

--  [[ SURROUND ]]  {{{
require("nvim-surround").setup({})
-- }}}

-- [[ TREESITTER ]] {{{
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024   -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('aerial').setup({
  layout = {
    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "prefer_left",

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = "window",

    -- When the symbols change, resize the aerial window (within min/max constraints) to fit
    resize_to_content = true,

    -- Preserve window size equality with (:help CTRL-W_=)
    preserve_equality = false,
  },
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
-- }}}

--  [[ TESTING ]]  {{{
vim.g['test#strategy'] = 'neoterm'
vim.keymap.set('n', '<leader>rt', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<leader>rf', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', '<leader>ra', ':TestSuite<CR>', { silent = true })
vim.keymap.set('n', '<leader>rl', ':TestLast<CR>', { silent = true })
vim.keymap.set('n', '<leader>rg', ':TestVisit<CR>', { silent = true })
-- }}}

--  [[ TERMINAL ]]  {{{
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_automap_keys = ',tt'
vim.g.neoterm_autoscroll = 1
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set('n', ',to', ':Topen<cr>', { silent = true })
vim.keymap.set('n', ',tc', ':Tclose<cr>', { silent = true })
vim.keymap.set('n', ',tl', ':Tclear<cr>', { silent = true })
vim.keymap.set('n', ',tk', ':Tkill<cr>', { silent = true })
vim.keymap.set('n', '<leader>ri', ':T <right>')

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})
-- }}}

--  [[ FILE MANAGER ]]  {{{
require('oil').setup({})

vim.keymap.set('n', '-', require("oil").open, { desc = "Open parent directory" })
-- }}}

-- [[ ICON PICKER ]] {{{
  require('dressing').setup({})
  require("icon-picker").setup({ disable_legacy_commands = true })
-- }}}

--  [[ FUZZY FINDER ]]  {{{
local fzflua = require('fzf-lua')
vim.keymap.set('n', '<leader>b', fzflua.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>t', fzflua.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gf', fzflua.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>gb', fzflua.git_branches, { desc = '[S]earch [G]it [B]ranches' })
vim.keymap.set('n', '<leader>sh', fzflua.helptags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', fzflua.grep, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', fzflua.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', fzflua.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
-- }}}

-- [[ COMPLETION ]] {{{
-- kill annoying deprecation messages
-- vim.deprecate = function() end ---@diagnostic disable-line: duplicate-set-field
vim.opt.shortmess:append "c"
require('completion')
-- }}}

--  [[ LSP ]]  {{{
require("fidget").setup({})
require('lsp')
-- }}}

-- [[ VISUAL ]] {{

-- blinking cursor all the way
vim.opt.guicursor = {
  'n-v-c:block',
  'i-ci-ve:ver25',
  'r-cr:hor20',
  'o:hor50',
  'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175'
}

require('onedark').setup {
  style = 'deep',
  transparent = true
}
require('onedark').load()

vim.cmd [[ hi Cursor guibg=#d33682 ]]
-- }}}

-- vim: foldmethod=marker
