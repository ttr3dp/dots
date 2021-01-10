if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" PLUGINS ----------------------------------------------------------------- {{{
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" Visual
Plug 'norcalli/nvim-colorizer.lua'
Plug '~/code/perun.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-bundler'
Plug 'joker1007/vim-ruby-heredoc-syntax'

" Coffeescript
Plug 'kchmck/vim-coffee-script'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Markdown
Plug 'tpope/vim-markdown'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Fuzzy finder
Plug 'junegunn/fzf.vim'

" Editing utils
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-dispatch'
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
" Show line numbers
set number
" Number of command to keep in history table
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
set tw=80
" Show margin at 81st character
set list
set listchars=tab:»·,trail:·,nbsp:·
" Split below/right by default
set splitbelow splitright
" Start diff mode in vertical split
set cursorline
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

" Completion popup
" Use a completion popup menu even if there is only one match
set completeopt=menu,preview

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

" SH --------------------------------------------------------------------- {{{
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
        \ "javascript" : {
        \   "start" : "JS",
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
" Default fzf layout
" down / up / left / right
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let width = float2nr(&columns * 0.9)
  let height = float2nr(&lines * 0.9)
  let opts = { 'relative': 'editor',
        \ 'row': (&lines - height) / 2,
        \ 'col': (&columns - width) / 2,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \}

  let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
endfunction

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --ignore --hidden --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
" Use leader + t for fuzzy-find
nnoremap <Leader>t :FZF<CR>
" Use leader + b for opened buffers list
nnoremap <Leader>b :Buffers<CR>
" }}}

" TESTING - vim-test ------------------------------------------------------- {{{
" Use Neoterm for running tests
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

" Easily get xrdb colors
function! ColorFor(nr)
  return system("get_color " . a:nr)[:-2]
endfunction

nmap <leader>- :<c-u>call Solarized8Contrast(-v:count1)<cr>
nmap <leader>+ :<c-u>call Solarized8Contrast(+v:count1)<cr>
" }}}

" VISUAL ------------------------------------------------------------------- {{{
function! Curbranch()
  if fugitive#head() != ''
    return '|  ' . fugitive#head()
  endif
endfunction


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}
EOF



set statusline=%f\ %{Curbranch()}\ %h%w%m%r\ %=%(%y\ %l,%c%V\ %=\ %P%)

set termguicolors
" Use dark background
set background=dark
colorscheme perun

hi Normal  guibg=NONE guifg=#afaf9d ctermbg=NONE
" hi LineNr  guibg=NONE ctermbg=NONE
hi StatusLine guibg=#999900 guifg=#262626 gui=bold
hi StatusLineNC guibg=#1a1a1a guifg=#333333
hi CursorLine guibg=#333333
hi Folded guibg=#333333
" hi VertSplit ctermbg=NONE ctermfg=2

lua require'colorizer'.setup()
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" }}}
