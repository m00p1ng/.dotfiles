# zsh_hightlight
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=43,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=154'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=154'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=154'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=197,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=197,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=229'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=199,bold'
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

# fixed auto sugestion
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
