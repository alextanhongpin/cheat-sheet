# Sharing configuration with vim

at `~/.config/nvim/init.vim`:

```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
```
