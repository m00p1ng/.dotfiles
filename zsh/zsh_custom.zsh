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
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --height 40% --reverse | sed 's/ *[0-9]* *//')
}

function lndir() {
    if [ $# -ne 2 ]
    then
        echo "lndir <source> <destination>"
        return 1
    fi

    find $1 -type d -exec mkdir -p $2/{} \;
    find $1 -type f -exec ln -s {} $2/{} \;
    mv $2$1 $2
}

# git log show with fzf
function git_log_fff() {
  # param validation
  if [[ ! `git log -n 1 $@ | head -n 1` ]] ;then
    return
  fi

  # filter by file string
  local filter
  # param existed, git log for file if existed
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  # git command
  local gitlog=(
    git log
    --graph --color=always
    --abbrev=7
    --format='%C(auto)%h %s %C(bold 081)%an %C(bold 191)%cr'
    $@
  )

  # fzf command
  local fzf=(
    fzf
    --ansi --no-sort --reverse --tiebreak=index
    --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter | delta; }; f {}"
  )

  # piping them
  $gitlog | $fzf
}

# Custom alias
alias cpi='rsync -rvh --progress'
alias mv='mv -i'
alias yt-l='youtube-dl -o "%(title)s.%(ext)s"'
alias kattis='~/.dotfiles/command/kattis-cli/kattis'
alias icloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs'
alias gff='git fuzzy'
alias pw="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias rg="rg --hidden --glob '!.git'"
