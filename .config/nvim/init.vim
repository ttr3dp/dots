au!

let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_rrhelper = 1
let g:loaded_remote_plugins = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'romainl/vim-cool'
Plug 'vim-crystal/vim-crystal'
call plug#end()

syn on
set shortmess+=I
set lazyredraw
set nobackup
set noswapfile
set autowrite
set history=101
set ttimeoutlen=100
set path+=**
set ignorecase
set smartcase
set hidden
set clipboard=unnamedplus
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set textwidth=80
set colorcolumn=+1
set cursorline
set nojoinspaces
set number
set relativenumber
set list
set listchars=tab:»·,trail:·,nbsp:·
set splitbelow
set splitright
set diffopt+=vertical
set mouse=a
set wildmenu
set completeopt=menu,preview
" set termguicolors
set undofile
set undodir=~/.local/share/nvim/.undodir
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,
      \**/.git/*,**/.bundle/*,**/bin/*,**/.svn/*,**/tmp/*
let &fillchars='eob: '

runtime! macros/matchit.vim

let g:mapleader = ' '
nnoremap <Leader><Leader> <C-^>
nnoremap <nowait> j gj
nnoremap <nowait> k gk
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <Leader>so :so $MYVIMRC<CR>
nnoremap <Leader>ev :edit $MYVIMRC<CR>
" expand active file dir in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" save file as sudo when root permission is needed
cnoremap w!! execute ':silent w !sudo tee % > /dev/null' <bar> :edit!
nnoremap <Leader>t :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
vmap <Enter> :EasyAlign<CR>

augroup MyAutoCmds
  au!
  " when editing a file, always jump to the last known cursor position,
  " except for commit messages or when the position is invalid
  au BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 2 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
  " strip whitespace on save
  au BufWritePre * :%s/\s\+$//e
  " save all files when vim loses focus
  au CursorHold,BufLeave,FocusLost * silent! wall

  au BufRead,BufNewFile Wagonfile,Gemfile,.pryrc,Vagrantfile setl ft=ruby

  au FileType ruby nnoremap <buffer><silent><leader>p orequire "pry"; binding.pry<esc>
  au FileType sh setl ts=4 sw=4
  au FileType vim setl foldenable foldmethod=marker foldlevelstart=0
  au FileType c,cpp setl sw=2 ts=2 noexpandtab
  au FileType crystal setl makeprg=crystal\ build\ %\ --no-color
  au FileType json setl synmaxcol=0
  au FileType xdefaults setl cms=/*%s*/ makeprg=xrdb\ %

  au BufRead,BufNewFile config.h,dwm.c,st.c,dmenu.c setl
        \ makeprg=make\ &&\ sudo\ make\ install\ &&\ sudo\ make\ clean
augroup END

set statusline=%f\ %{fugitive#statusline()}\ %h%w%m%r\ %=%(%y\ %l,%c%V\ %=\ %P%)

hi Normal ctermbg=NONE
hi Comment ctermbg=NONE ctermfg=239
hi ColorColumn ctermbg=234 ctermfg=7
hi CursorLine ctermbg=234 ctermfg=NONE cterm=NONE
hi CursorLineNR ctermfg=11 cterm=NONE
hi LineNR ctermfg=239
hi StatusLine ctermbg=234 ctermfg=248 cterm=bold
hi StatusLineNC ctermbg=234 ctermfg=242 cterm=NONE
hi VertSplit ctermfg=0 ctermbg=103

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
