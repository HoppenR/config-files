#
# ~/.bashrc
# /root/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors for 'ls'
if type -P dircolors > /dev/null
then
	if [[ -f ~/.dir_colors ]]
	then
		eval $(dircolors -b ~/.dir_colors)
	elif [[ -f /etc/DIR_COLORS ]]
	then
		eval $(dircolors -b /etc/DIR_COLORS)
	fi
fi

# Set colorful $PS1
if [[ ${EUID} == 0 ]]
then
	PS1="\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] "
else
	PS1="[\u@\h \[\033[38;5;81m\]\W\[\033[0m\]]\\$ "
fi

# Alias tools to add colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Set the X Window title
PROMPT_COMMAND='printf "\033]0;[%s@%s %s]\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

## Variables
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

## Aliases
alias cp="cp -i" # Ask for confirmation before overwrite
alias mv="mv -i" # Ask for confirmation before overwrite
alias df="df -h" # Human readable output
alias free="free -m" # Display in Mebibytes

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
