call plug#begin()
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'uZer/pywal16.nvim', { 'as': 'pywal16' }
Plug 'martineausimon/nvim-xresources'
call plug#end()

filetype plugin on

set autoindent
set clipboard=unnamedplus
set cursorline
set expandtab
set hidden
set list
set listchars=tab:»·,trail:·,nbsp:·
set mouse=a
set noswapfile
set number
set shiftround
set shiftwidth=4
set showmatch
set splitbelow
set splitright
set tabstop=4
set undofile
set wildoptions+=fuzzy

let mapleader = " "

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <Leader>t :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>sg :RG<CR>

" expand active file dir in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" save file as sudo when root permission is needed
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

augroup acmds
  " strip whitespace on save
  au BufWritePre * :%s/\s\+$//e
  " save all files when vim loses focus
  au CursorHold,BufLeave,FocusLost * silent! wall
augroup END

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax on
set termguicolors
set background=dark

lua << EOF
require'colorizer'.setup()
require('nvim-xresources').setup({
    --  Optional config:
    xresources_path = os.getenv("XDG_CONFIG_HOME") .. '/x11/xresources',
    --  auto_light = {
    --    enable = true,
    --    value = 0.5,
    --    exclude = {},
    --  },
    --  contrast = 1,
    bold = false,
    --  palette_overrides = {},
    --  fallback_theme = "nord"
    })
EOF

colorscheme xresources

highlight Normal ctermbg=NONE guibg=NONE
