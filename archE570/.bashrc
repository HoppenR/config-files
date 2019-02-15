#!/bin/bash
#
# ~/.bashrc
# /root/.bashrc
#
# Vim: set tabstop=4 :


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors for 'ls'
if type -P dircolors > /dev/null
then
	if [[ -r ~/.dir_colors ]]
	then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -r /etc/DIR_COLORS ]]
	then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	fi
fi

# Set PS variables for use by 'update_ps1'
if [[ $EUID -eq 0 ]]
then
	PS_START="\\[\\033[01;31m\\][\\h \\[\\033[01;36m\\]\\W\\[\\033[01;31m\\]]\\[\\033[0m\\]"
	PS_SYMBOL="#"
else
	PS_START="[\\u@\\h \\[\\033[38;5;50m\\]\\W\\[\\033[0m\\]]"
	PS_SYMBOL="$"
fi

if [[ -r /usr/share/git/git-prompt.sh ]]
then
	# (disable not following other people's code)
	# shellcheck disable=SC1091
	source /usr/share/git/git-prompt.sh
fi
function update_ps1 {
	# get the last command's exit status, then color symbol
	# blue if exit code was 0, red if not
	# (disable "Check exit code directly" because we are checking the last user executed exit code)
	# shellcheck disable=SC2181
	if [[ $? -eq 0 ]]
	then
		local symbol="\\[\\033[1;38;5;50m\\]${PS_SYMBOL:-%}\\[\\033[0m\\]"
	else
		local symbol="\\[\\033[1;38;5;09m\\]${PS_SYMBOL:-%}\\[\\033[0m\\]"
	fi
	__git_ps1 "${PS_START:-}" "$symbol " "(%s)"
}

# My own Prompt Strings
export PS2=$' ${LINENO: -1}>\t'
export PS3=$' >#\n'

function cah {
	if [[ -n "$*" ]] && [[ -t 1 ]] && [[ -r ~/.highlight.theme ]]
	then
		highlight --tab=4 --config-file="/home/$USER/.highlight.theme" --out-format=xterm256 --force --stdout "$@"
	else
		/bin/cat "$@"
	fi
}

function d { differ.sh; }
function o { overrustlechecker.sh -s"${1:-}" && exit; }
function p { pull.sh; }
function P { pull.sh -p; }
function presentationmode {
	#TODO: trap signals and disable presentation mode
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode --set true
	sleep "$(bc <<< "${1:-60} * 60")"
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode --set false
}

## Pre-command
# Set X title to the running command
# (disable "Expressions don't expand in single quotes" because we don't want it to expand at source time)
# shellcheck disable=SC2016
export PS0='$(printf "\033]0;RUNNING: [%s]\007" "$(history 1 | cut -c 8- | sed "s/[\x01-\x1F\x7F]/^[/g")")'
## Post-command
# Call 'update_ps1' and set the X Window title after every command
PROMPT_COMMAND='update_ps1; history -a; printf "\033]0;[%s@%s %s]\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

## Aliases
alias :q="exit"
# Tool options
alias bc="bc -l"     # Mathlib for decimal point calculation
alias cp="cp -i"     # Ask for confirmation before overwrite
alias df="df -h"     # Human readable output
alias free="free -h" # Human readable output
alias mv="mv -i"     # Ask for confirmation before overwrite
alias cower="cower -v"
# Color aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"

## Options
shopt -s checkwinsize
shopt -s dotglob
shopt -s no_empty_cmd_completion
stty -ixon
tabs -4

# Set terminal settings / banner depending on context
if [[ -n $VIMRUNTIME ]]
then
	# Enable blinking cursor inside vim terminal (workaround)
	echo -ne "\\x1b[ q\\e]12;#16A085\\x7"
	echo "Welcome to vim!"
fi

## Variables specific to bash
HISTFILESIZE=20000
HISTSIZE=20000

if [[ -r /usr/share/bash-completion/bash_completion ]]
then
	# (disable not following other people's code)
	# shellcheck disable=SC1091
	source /usr/share/bash-completion/bash_completion
fi
