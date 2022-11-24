#
# ~/.config/zsh/.zshrc
#

# If not running interactively, don't do anything
if [[ $- != *i* ]]; then
    return
fi

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Options
setopt    MENU_COMPLETE
setopt    PROMPT_SUBST
setopt no_CASE_GLOB
stty -ixoff
stty -ixon
tabs -4

# Prompt and colors
autoload -U colors
colors
PS1='[%n@%m %F{50}%c%f$(__git_ps1 " (%s)")]%(?.%F{50}.%F{red})$%f '
if [[ -r ~/.config/DIR_COLORS && -x /bin/dircolors ]]
then
    eval "$(dircolors ~/.config/DIR_COLORS)"
elif [[ -r /etc/DIR_COLORS && -x /bin/dircolors ]]
then
    eval "$(dircolors /etc/DIR_COLORS)"
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Mappings
zmodload zsh/complist
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '§' autosuggest-accept
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^y' accept-line
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M vicmd '.' vi-yank-arg

# Environment variables
DISABLE_AUTO_TITLE='true'
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
KEYTIMEOUT=1
SAVEHIST=10000
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=102'

# Prompt-command
function precmd() {
    printf '\033]0;[%s@%s %s]\007' "${USER}" "${HOST%%.*}" "${PWD/#$HOME/\~}"
}

# Aliases
alias :q='exit'
alias p='pull.sh'
alias P='pull.sh -p'
# Tools
alias vim='nvim'
alias vimdiff='nvim -d'
alias bc='bc -l'       # Mathlib for decimal point calculation
alias cp='cp -i'       # Ask for confirmation before overwrite
alias df='df -h'       # Human readable output
alias free='free -h'   # Human readable output
alias mv='mv -i'       # Ask for confirmation before overwrite
alias rm='rm -i'       # Ask for confirmation before deletion
# Color aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Functions
function zle-keymap-select {
  cursor_block='\e[2 q'
  cursor_beam='\e[5 q'
  if [[ ${KEYMAP} == vicmd ]] ||
      [[ $1 = 'block' ]]; then
        echo -ne $cursor_block
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
  fi
}
zle-line-init() {
    zle-keymap-select 'beam'
}
vi-yank-arg() {
  NUMERIC=1 zle .vi-add-next
  zle .insert-last-word
}

# Widgets
zle -N vi-yank-arg
zle -N zle-keymap-select
zle -N zle-line-init

# Plugins
if [[ -r /usr/share/git/git-prompt.sh ]]; then
    source /usr/share/git/git-prompt.sh
fi
if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi
plugins=(
    zsh-autosuggestions
)
