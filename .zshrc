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

plugins=(zsh-syntax-highlighting git node npm brew osx)
export CLICOLOR=1
export PATH="/Users/UnnamE/anaconda/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/CrossPack-AVR/bin"

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

# Include Z
. ~/.dotfile/z.sh

# Run some command
echo "\033[1;37;40m===== Vocab of The Day =====\033[0m"
rl ~/.dotfile/dict/3000oxford.txt -c 10
printf "\n"

export EDITOR=vim

# Custom script
function mkcd {
    mkdir -p $1
    cd $1
}

zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.class'

# Custom alias
alias haha='open /Volumes/UnnamE/OS_Windows/Game/PS/Recycle\ Bin'
alias cpi='rsync -rvh --progress'
alias mv='mv -i'
alias composer='php ~/.composer.phar'
alias web='cd /Applications/XAMPP/xamppfiles/htdocs/'
alias ubuntu='/Applications/VMware\ Fusion.app/Contents/Library/vmrun -T fusion start ~/Documents/Virtual\ Machines.localized/Ubuntu\ 64-bit\ 16.04.1.vmwarevm/Ubuntu\ 64-bit\ 16.04.1.vmx nogui'
alias ctest='~/.dotfile/command/ctest.py'
alias yt-l='youtube-dl -o "%(title)s.%(ext)s"'
