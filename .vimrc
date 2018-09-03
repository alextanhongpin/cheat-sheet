execute pathogen#infect()
syntax on
filetype indent plugin on

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

"Set italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set termguicolors
set encoding=utf-8
set clipboard=unnamed
set ruler
set number
set relativenumber
set mouse=a
set laststatus=2
set colorcolumn=80
set cursorline

"Set split
set splitbelow
set splitright

"Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Set themes
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \ 	 'default': {
  \        'transparent_background': 0,
  \        'allow_bold': 1,
  \        'allow_italic': 1,
  \	 }
  \    }
  \ }

set background=light
colorscheme PaperColor 
let g:airline_theme='papercolor'

"Overwrite background and comments color
"highlight Normal ctermfg=black ctermbg=white
"highlight NonText ctermbg=white cterm=bold
"highlight Comment ctermfg=white ctermbg=grey
"highlight Special cterm=bold

"Set Golang
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

"Set JavaScript
let g:ale_linters = {
\   'javascript': ['standard'],
\}

autocmd bufwritepost *.js silent !standard --fix %
set autoread

" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

"Set NERDTree
autocmd vimenter * NERDTree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" Set space for JavaScript
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab 

let g:pymode_python = 'python3'
let g:pymode_indent = 0
let python_highlight_all=1

autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab
