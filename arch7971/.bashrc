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
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]]
	then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	fi
fi

# Set PS variables for use by 'update_ps1'
if [[ ${EUID} == 0 ]]
then
	PS_START="\[\033[01;31m\][\h \[\033[01;36m\]\W\[\033[01;31m\]]\[\033[0m\]"
	PS_SYMBOL="#"
else
	PS_START="[\u@\h \[\033[38;5;81m\]\W\[\033[0m\]]"
	PS_SYMBOL="$"
fi

function update_ps1 {
	# get the last command's exit status, then color symbol
	# blue if exit code was 0, red if not
	if [[ $? -eq 0 ]]
	then
		local symbol="\[\033[1;38;5;81m\]$PS_SYMBOL\[\033[0m\]"
	else
		local symbol="\[\033[1;38;5;09m\]$PS_SYMBOL\[\033[0m\]"
	fi
	# check if we are inside a git repository
	if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == true ]]
	then
		# check if we are ahead of remote repository, then color git indicator
		# green if up to date, red if ahead
		if [[ -z $(git log origin/master..HEAD 2>/dev/null) ]]
		then
			local git_status="\[\033[1;38;5;10m\](git)\[\033[0m\]"
		else
			local git_status="\[\033[1;38;5;09m\](git)\[\033[0m\]"
		fi
	fi
	export PS1="$PS_START$git_status$symbol "
}

# My own Prompt Strings
export PS2=$' ${LINENO: -1}>\t'
export PS3=$' >#\n'

function cat {
	if [[ ! -z $* ]] && [[ -t 1 ]]
	then
		highlight --tab=4 --config-file="/home/$USER/.highlight.theme" --out-format=xterm256 --force "$@"
	else
		/bin/cat "$@"
	fi
}

function s {
	streamchecker.sh -s"$1" && exit
}

function o {
	overrustlechecker.sh -s"$1" && exit
}

## Post-command
# Call 'update_ps1' and set the X Window title after every command
PROMPT_COMMAND='update_ps1; printf "\033]0;[%s@%s %s]\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

## Aliases
alias :q="exit"
cleanpaccache="paccache -vruk0 && paccache -rv"
# Tool options
alias bc="bc -l"     # Mathlib for decimal point calculation
alias cp="cp -i"     # Ask for confirmation before overwrite
alias df="df -h"     # Human readable output
alias free="free -h" # Human readable output
alias mv="mv -i"     # Ask for confirmation before overwrite
# Color aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"

## Options
shopt -s checkwinsize
shopt -s dotglob
shopt -s histappend
shopt -s no_empty_cmd_completion
tabs -4

# Enable cursor blink if run inside vim
if [[ $(ps --no-headers --format ucmd $PPID) == vim ]] && [[ $TERM != xterm ]]
then
	echo -ne "\x1b[ q"
fi

## Variables specific to bash
HISTFILESIZE=20000

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
