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
Plug 'blazkowolf/gruber-darker.nvim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'romainl/vim-cool'
Plug 'vim-crystal/vim-crystal'
Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set laststatus=3
set nojoinspaces
set number
set relativenumber
set list
set listchars=tab:»·,trail:·,nbsp:·
set splitbelow
set splitright
set diffopt+=vertical
set scrolloff=999
set mouse=a
set wildmenu
set completeopt=menu,preview
set termguicolors
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

" TERMINAL - Neoterm ------------------------------------------------------- {{{
let g:neoterm_default_mod='botright'
let g:neoterm_automap_keys = ',tt'

" Exit from terminal input with CTRL+Space
" On macOS <C-SPACE> changes input source, so make sure to remove that keybind
:tnoremap <C-SPACE> <C-\><C-n>

" open terminal
nnoremap <silent> ,to :Topen<cr>
" hide/close all terminals
nnoremap <silent> ,tc :Tclose<cr>
" clear terminal
nnoremap <silent> ,tl :Tclear<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tk :Tkill<cr>
" Send command to neoterm (ri - Run Interactive)
nnoremap <leader>ri :T <right>
" }}}

" TESTING - vim-test ------------------------------------------------------- {{{
"iUse Neoterm for running tests
let test#strategy = "neoterm"
" Autoscroll through output
let g:neoterm_autoscroll = 1

" Vim-test mappings
nmap <silent> <leader>rt :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>
" }}}

" LSP - COC ---------------------------------------------------------------- {{{
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-html', 'coc-solargraph', 'coc-sh', 'coc-markdownlint', 'coc-lua']
" }}}
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
  au FileType php setl ts=4 sw=4
  au BufRead,BufNewFile config.h,dwm.c,st.c,dmenu.c setl
        \ makeprg=make\ &&\ sudo\ make\ install\ &&\ sudo\ make\ clean

 " Don't auto-wrap text using textwidth (-=t)
 " Don't auto-wrap comments using textwidth (-=c)
 " Don't insert comment leader automatically (-=c)
 " Don't insert current comment leader after hitting <Enter> in Insert mode (-=r)
 " Don't insert current comment leader after hitting 'o'/'O' in Normal mode (-=o)
  " autocmd FileType * :set
  "       \ formatoptions-=t
  "       \ formatoptions-=c
  "       \ formatoptions-=r
  "       \ formatoptions-=o
augroup END

" Easily rename file and buffer
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>rn :call RenameFile()<cr>

set statusline=%f\ %{fugitive#statusline()}\ %h%w%m%r\ %=%(%y\ %l,%c%V\ %=\ %P%)

colorscheme GruberDarker

hi Normal guibg=NONE guifg=#cbcbcb
hi NormalNC guibg=NONE guifg=#cbcbcb
hi Identifier guifg=#cbcbcb
hi DiffAdded guifg=#73d936
hi DiffDelete guifg=#f43841
hi DiffChange guifg=#ffdd33
hi Folded guibg=#282828
hi diffRemoved guifg=#f43841
hi EndOfBuffer guibg=NONE
" hi StatusLine guibg=#262626 guifg=#cc8b66
" hi CursorLine guibg=#262626
" hi WinSeparator ctermfg=250 ctermbg=234 guifg=#282828 guibg=#1c1c1c

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
