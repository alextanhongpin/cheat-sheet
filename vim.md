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
syntax on
set t_Co=256
set termguicolors
colorscheme onedark

execute pathogen#infect()

autocmd vimenter * NERDTree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


set ruler
set number
set relativenumber
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
```

## For js syntax highlighting
https://github.com/pangloss/vim-javascript
