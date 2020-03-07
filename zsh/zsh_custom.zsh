# Custom script
function mkcd {
    mkdir -p $1 && cd $1
}

function dict {
    open dict://$1
}

function runcpp {
    file=/tmp/a.out
    g++ $1 -o $file && $file
}

function runrust {
    file=/tmp/rust_exec
    rustc $1 -o $file && $file
}

function fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Custom alias
alias cpi='rsync -rvh --progress'
alias mv='mv -i'
alias yt-l='youtube-dl -o "%(title)s.%(ext)s"'
alias kattis='~/.dotfiles/command/kattis-cli/kattis'
