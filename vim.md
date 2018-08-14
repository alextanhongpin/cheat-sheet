# Inserting Date

```bash
$ :r !date
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

execute pathogen#infect()
syntax on
set t_Co=256
set termguicolors

colorscheme dracula
let g:airline_theme='dracula'
"""colorscheme onedark"""
"""colorscheme dracula"""
"""colorscheme grb256"""

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
set textwidth=80
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
