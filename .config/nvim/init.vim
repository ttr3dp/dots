if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

" PLUGINS ----------------------------------------------------------------- {{{
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" Visual
Plug 'Gavinok/spaceway.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'joker1007/vim-ruby-heredoc-syntax'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Crystal
Plug 'vim-crystal/vim-crystal'

" Markdown
Plug 'tpope/vim-markdown'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Fuzzy finder
Plug 'junegunn/fzf.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

" Completion
Plug 'hrsh7th/nvim-compe'

" Editing utils
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'unblevable/quick-scope'

" Testing
Plug 'janko-m/vim-test'

" Shell/Terminal interaction
Plug 'kassio/neoterm'
call plug#end()
" }}}

" GENERAL SETTINGS --------------------------------------------------------- {{{

filetype plugin indent on
syntax on
" Remove start buffer content
set shortmess+=I
set lazyredraw
set noshowcmd
" Don't generate backup nor swap files
set nobackup
set nowritebackup
set noswapfile
" Auto-save
set autowrite
" If file is changes outside of vim, reload it right away
set autoread
" Number of commands to keep in history table
set history=100
" Set timeout length
set ttimeout
set ttimeoutlen=100
set path+=**
" Put everything in unnamed register (or maybe I'm wrong)
:let @/ = ""
" Ignore the case of letters
set ignorecase
" Ignore case if pattern contains only lowercase letters
set smartcase
" Substitute all matches in a line by default
set gdefault
" Can switch buffers even though current one is not saved
set hidden
" Set default clipboard
set clipboard=unnamedplus
" Tab is 2 spaces
set tabstop=2
" Number of spaces to use for each step of (auto)indent
set shiftwidth=2
" Round indent to multiple of 'shiftwidth' when using '>' and '<' commands
set shiftround
set expandtab
" Open all folds by default
set nofoldenable
" Text width at 80 characters
set textwidth=80
" Show margin at 81st character
" set colorcolumn=+1
set number
" Remove ~ at EOB
let &fcs='eob: '
set list
set listchars=tab:»·,trail:·,nbsp:·
" Split below/right by default
set splitbelow splitright
" Start diff mode in vertical split
set diffopt+=vertical
" Enable mouse
set mouse=a
" Tags
set tags=tags
" Autocompletion
set wildmenu
set wildmode=full
" Specify what to ignore
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,
      \**/.git/*,**/.bundle/*,**/bin/*,**/.svn/*,**/tmp/*

" Window height & width
set winheight=10
set winminheight=10
set winwidth=90
set winheight=999

" Persistent undo dir (Maintain undo history between sessions)
set undofile
set undodir=~/.config/nvim/.persistent_undo

" extended % matching
runtime! macros/matchit.vim
" }}}

" SH ----------------------------------------------------------------------- {{{
augroup filetype_sh
  autocmd!
  autocmd FileType sh setlocal tabstop=4 shiftwidth=4
augroup END
" }}}

" RUBY --------------------------------------------------------------------- {{{
" Set syntax highlighting for specific file types
augroup rubyfiletypes
  autocmd!
  " Set ruby filetype for Vagrantfile, Gemfile, Guardfile, .pryrc and arb files
  au BufRead,BufNewFile Wagonfile setlocal filetype=ruby
  au BufRead,BufNewFile Gemfile setlocal filetype=ruby
  au BufRead,BufNewFile pryrc setlocal filetype=ruby
  au BufRead,BufNewFile Vagrantfile setlocal filetype=ruby
  autocmd FileType ruby nnoremap <buffer><silent><leader>p orequire "pry"; binding.pry<esc>
augroup END

let g:ruby_operators = 1
" HEREDOC Support
let g:ruby_heredoc_syntax_defaults = {
        \ "json" : {
        \   "start" : "JSON",
        \},
        \ "sql" : {
        \   "start" : "SQL",
        \},
        \ "html" : {
        \   "start" : "HTML",
        \},
        \ "xml" : {
        \   "start" : "XML",
        \},
        \ "ruby" : {
        \   "start" : "RUBY",
        \},
        \ "javascript" : {
        \   "start" : "JS",
        \}
  \}
" }}}

" SLIM --------------------------------------------------------------------- {{{
" Set filetype to slim for .slim files
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
" }}}

" VIMSCRIPT ---------------------------------------------------------------- {{{
augroup filetype_vim
  autocmd!

  " Fold Vimscript
  autocmd FileType vim setlocal foldenable
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevelstart=0
augroup END
" }}}

" MARKDOWN ----------------------------------------------------------------- {{{
 let g:markdown_fenced_languages = ['html', 'ruby', 'bash=sh']
 let g:markdown_minlines = 100
" }}}

" MAPPINGS ----------------------------------------------------------------- {{{
" Map leader to SPACE
let mapleader = " "

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Normal moving through long wrapped lines
nnoremap <nowait> j gj
nnoremap <nowait> k gk

" Quicker window movement (exclude 'w' from mappings)
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Easier :nohl
nnoremap <leader><cr> :nohl<cr>

" Edit $MYVIMRC
nnoremap <leader>ev :e $MYVIMRC<cr>
" Source $MYVIMRC
nnoremap <leader>so :so $MYVIMRC<cr>

" Expand active file dir in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Save file as sudo on files that require root permission
cnoremap w!! execute ':silent w !sudo tee % > /dev/null' <bar> :edit!
" }}}

" ABBREVIATIONS ------------------------------------------------------------ {{{
iabbrev lenght length
iabbrev widht width
iabbrev initilaze initialize
iabbrev valdiation validation
" }}}

" TERMINAL - Neoterm ------------------------------------------------------- {{{
let g:neoterm_default_mod='botright'
let g:neoterm_automap_keys = ',tt'

" Exit from terminal input with CTRL+Space
:tnoremap <C-SPACE> <C-\><C-n>

" open terminal
nnoremap <silent> ,to :Topen<cr>
" hide/close all terminals
nnoremap <silent> ,tc :Tclose<cr>
" clear terminal
nnoremap <silent> ,tl :Tclear<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tk :Tkill<cr>
" Send command to neoterm
nnoremap <leader>ri :T <right>
" }}}

" FZF ---------------------------------------------------------------------- {{{
" FUZZY FINDER
" fzf
"-------------------------------------------------------------------------------
nnoremap <Leader>t :FZF<CR>
" Use leader + b for opened buffers list
nnoremap <Leader>b :Buffers<CR>
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

" LSP ---------------------------------------------------------------------- {{{
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
" }}}

" ALIGNMENTS - EasyAlign --------------------------------------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" }}}

" MOVING - Quick-scope ----------------------------------------------------- {{{
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}

" AUTOCOMMANDS ------------------------------------------------------------- {{{
augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " strip whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

 " Don't auto-wrap text using textwidth (-=t)
 " Don't auto-wrap comments using textwidth (-=c)
 " Don't insert comment leader automatically (-=c)
 " Don't insert current comment leader after hitting <Enter> in Insert mode (-=r)
 " Don't insert current comment leader after hitting 'o'/'O' in Normal mode (-=o)
  autocmd FileType * :set
        \ formatoptions-=t
        \ formatoptions-=c
        \ formatoptions-=r
        \ formatoptions-=o
augroup END

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

autocmd FileType c set shiftwidth=2 tabstop=2 noexpandtab
autocmd FileType cpp set shiftwidth=2 tabstop=2 noexpandtab

autocmd FileType xdefaults setl cms=/*%s*/ makeprg=xrdb\ %

autocmd FileType crystal setl makeprg=crystal\ build\ %\ --no-color

autocmd BufRead,BufNewFile config.h setl makeprg=make\ &&\ sudo\ make\ install\ &&\ sudo\ make\ clean
autocmd BufRead,BufNewFile dwm.c    setl makeprg=make\ &&\ sudo\ make\ install\ &&\ sudo\ make\ clean
autocmd BufRead,BufNewFile st.c     setl makeprg=make\ &&\ sudo\ make\ install\ &&\ sudo\ make\ clean
autocmd BufRead,BufNewFile dmenu.c  setl makeprg=make\ &&\ sudo\ make\ install\ &&\ sudo\ make\ clean

" Save all files when vim loses focus
augroup autoSave
  autocmd!
  autocmd CursorHold,BufLeave,FocusLost * silent! wall
augroup END

augroup compilers
  autocmd!
  autocmd FileType ruby compiler rubylint
  autocmd FileType sh compiler shlint
augroup END
" }}}

" CUSTOM FUNCTIONS --------------------------------------------------------- {{{
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

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

" VISUAL ------------------------------------------------------------------- {{{
function! Curbranch()
  if fugitive#head() != ''
    return '|  ' . fugitive#head()
  endif
endfunction

" Use 24-bit colors
set termguicolors
" Add git branch to statusline
set statusline=%f\ %{Curbranch()}\ %h%w%m%r\ %=%(%y\ %l,%c%V\ %=\ %P%)

" Use dark background
set background=dark
" Set colorscheme
colorscheme spaceway

" Some custom syntax highlighting
hi Normal          ctermbg=NONE guibg=#0c0d0e
" hi ColorColumn     guibg=#415367
" hi NonText       ctermbg=NONE
" hi Comment       ctermfg=238
" hi LineNr        ctermfg=235
" hi VertSplit     ctermfg=0 ctermbg=238
" hi StatusLineNC  cterm=NONE ctermfg=145 ctermbg=0
" hi StatusLine    cterm=NONE ctermfg=120 ctermbg=0
" hi Visual guibg=#1d1d1d
" hi Folded guifg=#dedede guibg=#1d1d1d

" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" }}}

lua <<EOF
require("lsp")
require("completion")
EOF

