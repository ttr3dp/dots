require('ttr3dp.vim-plug').add({
  'tpope/vim-sleuth',
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-endwise',
  'kylechui/nvim-surround',
  'unblevable/quick-scope',
  'romainl/vim-cool',

  -- git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'junegunn/gv.vim',

  'tpope/vim-rsi',

  'nvim-tree/nvim-web-devicons',
  'NvChad/nvim-colorizer.lua',

  'kassio/neoterm',
  'janko-m/vim-test',

  {
    'iamcco/markdown-preview.nvim',
    [[ { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} ]]
  },

  -- symbol/icon picker
  'stevearc/dressing.nvim',
  'ziontee113/icon-picker.nvim',

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } },
  'nvim-treesitter/nvim-treesitter-textobjects',

  'stevearc/aerial.nvim',

  -- file browser
  'stevearc/oil.nvim',

  -- fuzzy-finder
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  { 'nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' } },

  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'onsails/lspkind.nvim',

  -- snippets
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',

  -- LSP
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'folke/neodev.nvim',

  -- linter
  -- 'mfussenegger/nvim-lint'

  -- colorsheme
  'maxmx03/fluoromachine.nvim'
})

-- load all plugin configs from ./
local dir = debug.getinfo(1).source:match("@?(.*/)")
local files = require('plenary.scandir').scan_dir(dir, { hidden = false, depth = 1 })
for _, file in ipairs(files) do
  local stem = vim.fn.fnamemodify(file, ':t:r')
  if not (stem == 'init') then
    local mod = string.format('ttr3dp.plugins.%s', stem)
    require(mod)
  end
end
