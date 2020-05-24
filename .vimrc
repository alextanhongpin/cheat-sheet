syntax on
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'alvan/vim-closetag'
Plugin 'cohama/lexima.vim'
Plugin 'cormacrelf/vim-colors-github'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go', {'do': ':GoUpdateBinaries', 'for': 'go'}
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'gorodinskiy/vim-coloresque', { 'for': ['css', 'scss'] }
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ludovicchabant/vim-gutentags', { 'for': ['js', 'ts'] }
Plugin 'kristijanhusak/vim-js-file-import', {'do': 'npm install', 'for':['js', 'ts']}

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'
" ...
"
" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on    " required

" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

" use `set filetype` to override default filetype=xml for *.ts files
" autocmd BufNewFile,BufRead *.ts  set filetype=typescript
" use `setfiletype` to not override any other plugins like ianks/vim-tsx
" autocmd BufNewFile,BufRead *.tsx set filetype=typescript
" autocmd BufNewFile,BufRead *.svelte set filetype=javascript

" vim-codefmt
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,protoAutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  " autocmd FileType typescript AutoFormatBuffer prettier-standard
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType md, markdown AutoFormatBuffer prettier
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType yaml AutoFormatBuffer prettier
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

" Map leader \ to ,
let mapleader = ","

set notermguicolors
" set swapfile
set dir=~/tmp
set encoding=utf-8
set clipboard=unnamed
set ruler
set number
set mouse=a
set laststatus=2
set colorcolumn=80
set cursorline
set cursorcolumn
set relativenumber
syntax sync minlines=256
set nocompatible
set inccommand=nosplit
set splitright

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
" use a slightly darker background, like GitHub inline code blocks
let g:github_colors_soft = 1

" more blocky diff markers in signcolumn (e.g. GitGutter)
let g:github_colors_block_diffmark = 0
" in your .vimrc or init.vim
colorscheme github
highlight Normal ctermbg=white
highlight nonText ctermbg=white

" if you use airline / lightline
let g:airline_theme = "github"
let g:lightline = { 'colorscheme': 'github' }

let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}

"Set JavaScript
let g:ale_linters = {
\   'rust': ['cargo'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'ruby': ['brakeman', 'standardrb', 'ruby', 'rails_best_practices', 'rubocop'],
\   'svelte': ['stylelint', 'eslint', 'prettier-standard']
\}
let g:ale_fixers = {
	\'ruby': ['sorbet', 'standardrb', 'rubocop'],
	\'rust': ['rustfmt'],
	\'vue': ['prettier-standard'],
	\'javascript': ['prettier'],
	\'typescript': ['prettier'],
	\'svelte': ['stylelint', 'eslint', 'prettier', 'prettier-standard'],
	\'*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_completion_enabled = 1
let g:ale_set_quickfix = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_rust_rls_toolchain = 'stable'

"Set NERDTree
augroup nerdtree
	autocmd!
	autocmd vimenter * NERDTree

	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	" Highlight currently open buffer in NERDTree
	autocmd BufEnter * call SyncTree()

augroup END

"Go back to the bar.
map <leader>r :NERDTreeFind<cr>

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

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" ctrlf + f to search
nnoremap <C-f> :Ag!<Enter>

" ctrl + s to save
noremap <silent> <C-S> :write<CR>
vnoremap <silent> <C-S> <C-C>:write<CR>
inoremap <silent> <C-S> <C-C>:write<CR>
" noremap jj <Esc>:w<CR>
"# ~/.zshrc
"# enable control-s and control-q
"stty start undef
"stty stop undef
"setopt noflowcontrol

"Insert mode key mappings
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-b> <C-o>o
inoremap <C-k> <Up><C-o>A
inoremap <C-d> <Right>,<C-o>o
inoremap <C-e> <Right>:<Space>,<Left>

"Improve search
set ignorecase
set smartcase
set incsearch
set hlsearch

nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

"Easy cd to directory with `,cd`
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"Center cursor vertically
set scrolloff=999
if !exists('*VCenterCursor')
  augroup VCenterCursor
  au!
  au OptionSet *,*.*
    \ if and( expand("<amatch>")=='scrolloff' ,
    \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
    \   au! VCenterCursor WinEnter,WinNew,VimResized|
    \ endif
  augroup END
  function VCenterCursor()
    if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
      let s:default_scrolloff=&scrolloff
      let &scrolloff=winheight(win_getid())/2
      au VCenterCursor WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
    else
      au! VCenterCursor WinEnter,WinNew,VimResized
      let &scrolloff=s:default_scrolloff
    endif
  endfunction
endif

nnoremap <leader>zz :call VCenterCursor()<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" Speed up vim syntax highlighting.
augroup vimrc
	autocmd!
	autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
augroup END


" Map jk to ESC in insert mode
inoremap jk <esc>

" Disable ESC key in insert mode.
inoremap <esc> <nop>

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" set swap config, Sets the directory to ~/.vim/tmp
set directory^=$HOME/.vim/tmp//

" vv to generate new vertical split
nnore map <silent> vv <C-w>v

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
