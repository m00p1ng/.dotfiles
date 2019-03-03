# default PROMPT for mooping eiei
local ret_status="%(?:%{$BG[073]%}%{$FG[015]%} %n %{$reset_color%}:%{$BG[009]%}%{$FG[015]%} %n %{$reset_color%})"
local dir="%{$FG[154]%}%c%{$reset_color%}"
local arrow="%{$FG[009]%}▶%{$reset_color%}%{$FG[011]%}▶%{$reset_color%}%{$FG[010]%}▶%{$reset_color%}"
PROMPT='
${ret_status} : ${dir} %{$FG[011]%}$(git_super_status)%{$FG[011]%}%{$reset_color%}
${arrow} '
RPROMPT='%{$FG[007]%}[%*${GREEN_END}]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FG[011]%})%{%G%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$FG[011]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[white]%}%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[white]%}%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"
