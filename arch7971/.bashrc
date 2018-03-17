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
	PS1="$PS_START$git_status$symbol "
}

function s {
	streamchecker.sh -s"$1" && exit
}

function o {
	overrustlechecker.sh -s"$1" && exit
}

# Alias tools to add colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Call 'update_ps1' and set the X Window title after every command
PROMPT_COMMAND='update_ps1; printf "\033]0;[%s@%s %s]\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

## Variables
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

## Aliases
alias cp="cp -i" # Ask for confirmation before overwrite
alias mv="mv -i" # Ask for confirmation before overwrite
alias df="df -h" # Human readable output
alias free="free -m" # Display in Mebibytes
alias bc="bc -l" # Mathlib for decimal point calculation

## Commands
tabs -4
shopt -s dotglob

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
