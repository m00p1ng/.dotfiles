# default PROMPT for mooping eiei
local ret_status="%(?:%{$BG[073]%}%{$FG[015]%} %n %{$reset_color%}:%{$BG[009]%}%{$FG[015]%} %n %{$reset_color%})"
local dir="%{$FG[154]%}%c%{$reset_color%}"
local arrow="%{$FG[009]%}▶%{$reset_color%}%{$FG[011]%}▶%{$reset_color%}%{$FG[010]%}▶%{$reset_color%}"
PROMPT='${ret_status} : ${dir} %{$FG[011]%}$(git_prompt_info)%{$FG[011]%}%{$reset_color%}${arrow} '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}%{$reset_color%}%{$FG[011]%}) "
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[042]%}%{$reset_color%}%{$FG[011]%}) "
