####################
##  Syntax Color  ##
####################
set fish_color_normal FFFB66
set fish_color_param FFFB66
set fish_color_command 00D7AF --bold
set fish_color_keyword 00D7AF --bold
set fish_color_quote FFFFAF
set fish_color_redirection 03C5C7 --bold
# set fish_color_end
set fish_color_error FF9D8F
set fish_color_option FF005F --bold
set fish_color_comment BFBFBF
# set fish_color_selection
# set fish_color_operator
set fish_color_escape FF6D68
# set fish_color_autosuggestion

####################
## Default prompt ##
####################
# set fish_color_cwd
# set fish_color_user
# set fish_color_host
# set fish_color_host_remote
# set fish_color_cancel
# set fish_color_search_match

###########
## Pager ##
###########
set fish_pager_color_progress FFFB66
# set fish_pager_color_background
# set fish_pager_color_prefix
# set fish_pager_color_completion
# set fish_pager_color_description
set fish_pager_color_selected_background -b 0087D7
set fish_pager_color_selected_prefix FFFFFF
set fish_pager_color_selected_completion FFFFFF
set fish_pager_color_selected_description FFFFFF
# set fish_pager_color_secondary_background
# set fish_pager_color_secondary_prefix
# set fish_pager_color_secondary_completion
# set fish_pager_color_secondary_description


##############
##  Prompt  ##
##############
function fish_prompt
  set -l left (get_left_prompt)
  set -l right (get_right_prompt)
  set -l padding_length (math $COLUMNS - (remove_color "$left$right" | string length))

  set -l padding (get_padding $padding_length)

  # traffic light arrow
  printf "\n$left$padding$right\n%s▶%s▶%s▶ " (set_color FF6D67) (set_color FEFB67) (set_color 56FF5F)
end

function get_left_prompt
  set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

  # git set up
  set -g __fish_git_prompt_color_prefix F8F565
  set -g __fish_git_prompt_color_suffix F8F565
  set -g __fish_git_prompt_color_branch F8F565
  set -g __fish_git_prompt_color_dirtystate 4F6BEE
  set -g __fish_git_prompt_color_stagedstate FF988F
  set -g __fish_git_prompt_color_invalidstate red
  set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
  set -g __fish_git_prompt_color_cleanstate green

  set -g __fish_git_prompt_show_informative_status 1
  set -g __fish_git_prompt_showuntrackedfiles 1
  set -g __fish_git_prompt_showupstream informative
  set -g __fish_git_prompt_showstashstate 1
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_char_upstream_prefix ' '

  if [ $__fish_last_status -eq 0 ]
    set_color -b 5FAFAF FFFFFF
  else
    set_color -b FF6D67 FFFFFF
  end
  echo -n " $USER "
  set_color -b normal normal; echo -n " : "
  set_color AFFF00
  if [ $PWD = $HOME ]
    echo -n "~"
  else
    echo -n (basename $PWD)
  end

  printf '%s' (fish_git_prompt)

  set -lx __git_output (fish_git_prompt)
  if [ (count $__git_output) -eq 1 ]
    set -lx __git_wip (git log -n 1 | grep -e "--wip--")
    if [ (count $__git_wip) -eq 1 ]
      printf "%s WIP!!!" (set_color FF6D67)
    end
  end
end

function get_padding
  set -l space ""

  for i in (seq 1 $argv[1])
    set space " "$space
  end

  set_color -b normal normal
  printf $space
end

function get_right_prompt
  printf '%s[%s]' (set_color C7C7C7) (date '+%H:%M:%S')
end

function remove_color
  printf $argv | perl -pe 's/\x1b.*?[mGKH]//g'
end

