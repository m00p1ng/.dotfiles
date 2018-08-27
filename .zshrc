# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
ZSH_THEME="mooping"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
 #ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(zsh-syntax-highlighting osx git zsh-autosuggestions zsh-completions)
export CLICOLOR=1
export PATH="/Users/UnnamE/anaconda3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="$HOME/.ssh"

# bindkey
bindkey -e "^p" up-line-or-beginning-search
bindkey -e "^n" down-line-or-beginning-search

# zsh_hightlight
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=154'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=154'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=197,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=197,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=15'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=1'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=15,bg=196'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=15,bg=9'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=11'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=204'
ZSH_HIGHLIGHT_STYLES[default]='fg=11'
ZSH_HIGHLIGHT_STYLES[assign]='fg=214'
ZSH_HIGHLIGHT_STYLES[comment]='fg=250'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=10,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=15,bg=6,bold'

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Include Z
. ~/.dotfiles/z.sh
. ~/.dotfiles/run.sh

export EDITOR=vim

# Custom script
function mkcd {
    mkdir -p $1 && cd $1
}

function dict {
    open dict://$1
}

zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.class'

# Custom alias
alias cpi='rsync -rvh --progress'
alias mv='mv -i'
alias yt-l='youtube-dl -o "%(title)s.%(ext)s"'
