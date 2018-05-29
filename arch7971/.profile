#!/bin/bash
# ~/.profile
#
#


export BROWSER="/usr/bin/firefox"
export EDITOR="/usr/bin/vim"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export LESS="-FRX -x4"
export PAGER="/usr/bin/less"
export PATH="/home/$USER/scripts/python:/home/$USER/shellscripts/:$PATH"
export TERMINAL="/usr/bin/termite"

eval $(ssh-agent)

