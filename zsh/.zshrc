# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RIPGREP_CONFIG_PATH=~/.ripgreprc
ZSH_THEME="mooping"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
  battery
  osx
  git
  git-prompt
  git-auto-fetch
  z
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)
export CLICOLOR=1
export PATH="/usr/local/anaconda3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/opt/homebrew/bin:$PATH

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH=$HOME/.ssh

# bindkey
bindkey -e "^p" up-line-or-beginning-search
bindkey -e "^n" down-line-or-beginning-search

# include config
CONFIG_PATH=$HOME/.dotfiles/zsh
. $CONFIG_PATH/zsh_custom.zsh
. $CONFIG_PATH/zsh_hightlight.zsh
. $CONFIG_PATH/git_prompt.zsh

export EDITOR=vim

zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.class'
