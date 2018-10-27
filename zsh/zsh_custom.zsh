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

# Custom alias
alias cpi='rsync -rvh --progress'
alias mv='mv -i'
alias yt-l='youtube-dl -o "%(title)s.%(ext)s"'
alias kattis='~/.dotfiles/command/kattis.py'