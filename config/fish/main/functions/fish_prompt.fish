function fish_prompt
  set -l left (get_left_prompt)
  set -l right (get_right_prompt)
  set -l padding_length (math $COLUMNS - (remove_color "$left$right" | string length))

  set -l padding (get_padding $padding_length)

  # traffic light arrow
  printf "\n$left$padding$right\n%s▶%s▶%s▶ " (set_color red) (set_color yellow) (set_color green)
end

function get_left_prompt
  set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

  # git set up
  set -g __fish_git_prompt_color_prefix yellow
  set -g __fish_git_prompt_color_suffix yellow
  set -g __fish_git_prompt_color_branch yellow
  set -g __fish_git_prompt_color_dirtystate blue
  set -g __fish_git_prompt_color_stagedstate fab387
  set -g __fish_git_prompt_color_invalidstate red
  set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
  set -g __fish_git_prompt_color_cleanstate green

  set -g __fish_git_prompt_show_informative_status 1
  set -g __fish_git_prompt_showuntrackedfiles 1
  set -g __fish_git_prompt_showupstream informative
  set -g __fish_git_prompt_showstashstate 1
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_char_upstream_prefix ''
  set -g __fish_git_prompt_char_upstream_ahead ''
  set -g __fish_git_prompt_char_upstream_behind ''

  if [ $__fish_last_status -eq 0 ]
    set_color -b blue black
  else
    set_color -b red black
  end
  echo -n " $USER "
  set_color -b normal normal; echo -n " : "
  set_color green
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
      printf "%s WIP!!!" (set_color red)
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
  printf '%s[%s]' (set_color grey) (date '+%H:%M:%S')
end

function remove_color
  printf $argv | perl -pe 's/\x1b.*?[mGKH]//g'
end

