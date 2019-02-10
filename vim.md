## Operating on search matches using gn
- http://vimcasts.org/episodes/operating-on-search-matches-using-gn/

```
- cgn # To delete word, repeat with dot (.)
- dgn # Delete word
```

## Visual Selection

```
prefix all with `v`
it # Select all within tags
at # Select the tag included
aw # mark a word
ab # a block with ()
aB # a block with {}
ib # inner block with ()
iB # inner block with {}
```
## Run the last command line

```
@:
```
## Clearing up registers

```
:qaq # Clears up register "a"
```
## Search

```
:%s/\<hello\>/world/g # Match exact words hello
:%s/hello\s\+world/hello world # Match all spaces between hello and world
```

## Go to column number

```vim
80| # Goes to column 80
```

## Format line to fit 80 characters
Normally for comments

```vim
:gqq
```

## Set vim as the main editor

```
https://stackoverflow.com/questions/2596805/how-do-i-make-git-use-the-editor-of-my-choice-for-commits
```

## Exit to background

```
ctrl + z (to go to bg)
$ fg (go resume)
```

## Copy whole file 

```vim
:Gygg # go to last line, copy until the first
```
## Register

```
:qaq # clean register a
:"ap # (visual mode) paste content from register a
:"adiw # (visual mode) use register a, then insert the deleted word (diw can be other motion like yy)
:ctrl+r + a # (edit mode) paste content from register a
```
## Sort/sort reverse

```
1,5sort  # Sort alphabetically from line 1 - 5
1,5sort! # Sort in reverse from line 1 - 5
.,+5sort # Sort from current line to next 5 lines (inclusive)
```

## Replace in selected lines

```
1,5s/foo/bar/g # Replace from line 1 to 5 (inclusive)
.,+4s/foo/bar/g # Replace from current line to next 4 lines (inclusive)
```
## Bookmark

```
# in normal mode
m followed by any characters (a-z)
press ` + the character to go to the location
press `` to move quickly between bookmarks
ctrl + g + j (when editing, this will conveniently go down to the next line, will not create new line)
# ctrl + o allows you to run one command only
ctrl + o + o (when editing, this will conveniently go down to the next line)
ctrl + o + shift + i (go to the first line while editing)
ctrl + o + shift + $ (go to the last line, alternatively, ctrl + o + a)
ctrl + o + u (quick undo)
ctrl + c while typing is the same as ctrl + [, which escapes insert mode
```

## Autocomplete Brackets

https://github.com/jiangmiao/auto-pairs

# Inserting Date

```bash
$ :r !date

# Include the date in the current file
$ :.date
```

## Simple Split

```
map <C-l> :vsplit<CR> (ctrl + l to split right)
map <C-j> :split<CR>
```

## Copy paste to clipboard
```
"*yy (to copy to clipboard)
"*p (to paste from clipboard)
```

## Others

```
:daw (delete all words)
:diw (delete word within)
:di" (delete all word within "")
:da" (delete word including "")
:dw (delete word)
:dt, (delete the whole line until the `,`, which can be anything)
:dfx (delete the whole line till x)
:shift + i (show hidden files)
:shift + r (refresh nerdtree)
```

## View folder directory 

Install pathogen: https://github.com/tpope/vim-pathogen
Install NERDTree: https://github.com/scrooloose/nerdtree


## Creating new file/directory NERDTree

Press `m` to bring up the NERDTree Filesystem Menu. 
```
NERDTree Menu. Use j/k/enter and the shortcuts indicated
==========================================================
> (a)dd a childnode
  (m)ove the current node
  (d)elete the current node
  (c)opy the current node
  (l)ist the current node
```


## .vimrc

```
syntax on

set t_Co=256
set termguicolors

colorscheme onedark
let g:airline_theme='onedark'

let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

set runtimepath^=~/.vim/bundle/ctrlp.vim

execute pathogen#infect()

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

set ruler
set number
set relativenumber
set mouse=a
```


## Adding Colorschemes
```bash
$ git clone https://github.com/flazz/vim-colorschemes.git

# after downloading; unpacking; cd'ing
$ cp colors/* ~/.vim/colors
```
In `.vimrc`:
```
colorscheme nameofcolorscheme
colo grb256
colo onedark
colo benokai
colo candypaper
colo papercolor
colo jellybeans
colo monokai
colo dracula
let g:airline_theme='dracula'
```

Another light theme alternative to github theme:

https://github.com/NLKNguyen/papercolor-theme

## For js syntax highlighting
https://github.com/pangloss/vim-javascript


## Vim standardjs setup

Install ale via pathogen:

https://github.com/w0rp/ale#standard-installation

```bash
$ cd ~/.vim/bundle
$ git clone https://github.com/w0rp/ale.git
```

Setup `.vimrc`

https://github.com/standard/standard

```.vimrc
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
```


## Vim-airline
```
$ git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
```

## Vim airline theme (including dracula)

https://github.com/vim-airline/vim-airline-themes


## Enable syntax highlighting for golang

```
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
```

## Insert mode shortcuts

```
ctrl + w: delete previous word
ctrl + u: delete whole line
ctrl + p/n: autocomplete suggestions
ctrl + [: exit insert mode, go to normal mode (easier to access than esc key)
```

## Normal mode shortcuts

```
:ddp - delete current line, paste it to next line (use to swap lines)
:%s/foo/bar/gI - replace all foo with bar, case sensitive
```

## Visual mode shortcuts

```
:< - unindent the line 
:> - indent the line
:vbx - enter visual mode, go backward one words and delete the word (faster to type ctrl + w)
:ctrl + v, ctrl + i // - enter visual mood multi-select, insert character for all positions
```

## Fuzzy Search

http://ctrlpvim.github.io/ctrlp.vim/#installation

## Scrolling in vim

```
:set mouse=a
```

## Reveal Folder when using fuzzy search

```.vimrc
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
```

## Tab to Space for Js

```

" Set space for JavaScript
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
```

## Find Files

http://ctrlpvim.github.io/ctrlp.vim/#installation

## Copy

```
"""set t_AB=^[[48;5;%dm"""
"""set t_AF=^[[38;5;%dm"""

execute pathogen#infect()
syntax on
filetype indent plugin on

set t_Co=256
set termguicolors

colorscheme dracula
let g:airline_theme='dracula'
"""colorscheme onedark"""
"""colorscheme dracula"""
"""colorscheme grb256"""

let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

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

autocmd vimenter * NERDTree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

set ruler
set number
set relativenumber
set mouse=a

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
autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab
```


## Add Color Column for Character width 80
```
set colorcolumn=80
```


## Vim Golang Plugins

```
go get -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/kisielk/errcheck
go get -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -u github.com/mdempsky/gocode
go get -u github.com/rogpeppe/godef
go get -u github.com/zmb3/gogetdoc
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter
go get -u github.com/fatih/gomodifytags
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/jstemmer/gotags
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/josharian/impl
go get -u honnef.co/go/tools/cmd/keyify
go get -u github.com/fatih/motion
go get -u github.com/koron/iferr
```

## Good Light Theme

Seoul256, Tomorow, PaperColor, and Solarized Light, gruvbox, hemisu and Kalisi.


## TypeScript + Vue support

```
# Install tsuquyomi.
git clone https://github.com/Quramy/tsuquyomi.git ~/.vim/bundle/tsuquyomi

# Syntax highlighting for Vue components.
Plugin 'posva/vim-vue'
# OR
cd ~/.vim/bundle && \
git clone https://github.com/posva/vim-vue.git

# Typescript
git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/bundle/typescript-vim
```

## Set tabwidth for specific language

Just put the settings into the filetype plugin file ~/.vim/ftplugin/LANGUAGE.vim . My ~/.vim/ftplugin/perl.vim contains the lines:

```.vimrc
"
" ---------- tabulator / shiftwidth --------------------
"  Set tabulator and shift width to 4 (Perl Style Guide)
"
setlocal  tabstop=2
setlocal  shiftwidth=2
"
```

## Format typescript
https://github.com/google/vim-codefmt
```bash
$ brew install clang-format
$ yarn global add prettier
$ yarn global js-prettify
```

# Alternative Theme
https://github.com/cormacrelf/vim-colors-github


## Modifying specific language indentation

```
# create folder if not exist
$ touch ~/.vim/ftplugin/LANGUAGE.vim

"
" ---------- tabulator / shiftwidth --------------------
"  Set tabulator and shift width to 4 (Perl Style Guide)
"
setlocal  tabstop=4
setlocal  shiftwidth=4
"
```
