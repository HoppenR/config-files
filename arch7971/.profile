#!/bin/bash
#
# ~/.profile
#

export BROWSER="/usr/bin/firefox"
export EDITOR="/usr/bin/vim"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export LESS="-FRX -x1,5"
export PAGER="/usr/bin/less"
PATH="/home/$USER/programs/sh:$PATH"
PATH="/home/$USER/programs/python/:$PATH"
PATH="/home/$USER/programs/go/streamshower/:$PATH"
export PATH
export TERMINAL="/usr/bin/termite"
export XDG_CONFIG_HOME="$HOME/.config"
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="true"
GOPATH=$(go env GOPATH)
export GOPATH

# clipmenu settings
export CM_HISTLENGTH=40
export CM_LAUNCHER=rofi
