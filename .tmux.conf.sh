#!/bin/bash

bind_copy=(bind-key -T copy-mode-vi MouseDragEnd1Pane)

# `tmux_bind_copy pbcopy` will make selecting with the mouse (and then
# releasing the selection) in tmux pipe the selection to `pbcopy`
function tmux_bind_copy {
        tmux "${bind_copy[@]}" send-keys -X copy-pipe-and-cancel "$@"
}

if [[ "$(uname)" == "Darwin" ]]
then
    # Copy with pbcopy on macOS
    tmux_bind_copy pbcopy
fi

if [[ ! -z "$WSL_DISTRO_NAME" ]]
then
    # copy with Windows' clip.exe on WSL
    tmux_bind_copy /mnt/c/Windows/System32/clip.exe
fi  
