{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx EDITOR nvim

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

      ### default prompt
      # set fish_color_cwd
      # set fish_color_user
      # set fish_color_host
      # set fish_color_host_remote
      # set fish_color_cancel
      # set fish_color_search_match

      ### Pager
      set fish_pager_color_progress FFFB66
      # set fish_pager_color_background
      # set fish_pager_color_prefix
      # set fish_pager_color_completion
      # set fish_pager_color_description
      set fish_pager_color_selected_background --background 0087D7
      set fish_pager_color_selected_prefix FFFFFF
      set fish_pager_color_selected_completion FFFFFF
      set fish_pager_color_selected_description FFFFFF
      # set fish_pager_color_secondary_background
      # set fish_pager_color_secondary_prefix
      # set fish_pager_color_secondary_completion
      # set fish_pager_color_secondary_description
    '';
    shellAliases = {
      vim = "nvim";
      mv = "mv -i";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      glg = "git log --stat";
      glgp = "git log --stat -p";
      gwip = "git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m \"--wip-- [skip ci]\"";
      gunwip = "git log -n 1 | grep -q -c \"\\-\\-wip\\-\\-\" && git reset HEAD~1";
      gignore = "git update-index --skip-worktree";
      gignored = "git ls-files -v | grep \"^S\"";
      gunignore = "git update-index --no-skip-worktree";

      showfiles = "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";
      hidefiles = "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";
      icloud = "cd ~/Library/Mobile\\ Documents/com\~apple\~CloudDocs";
      s = "kitty +kitten ssh";
      check_disk = "sudo smartctl --all /dev/disk0s1";
    };
    shellAbbrs = {
      g = "git";
      gl = "git pull";
      gp = "git push";
      gpo = "git push -u origin HEAD";
    };
    functions = {
      fish_prompt = ''
        set -l left (get_left_prompt)
        set -l right (get_right_prompt)
        set -l padding_length (math $COLUMNS - (remove_color "$left$right" | string length))

        if [ $TERM = "screen-256color" ]
          set padding_length (math $padding_length + 3)
        end

        set -l padding (get_padding $padding_length)

        # traffic light arrow
        printf "\n$left$padding$right\n%s▶%s▶%s▶ " (set_color FF6D67) (set_color FEFB67) (set_color 56FF5F)
      '';
      get_left_prompt = ''
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
        set -g __fish_git_prompt_hide_untrackedfiles 1
        set -g __fish_git_prompt_showupstream informative
        set -g __fish_git_prompt_showstashstate informative
        set -g __fish_git_prompt_char_stateseparator ' '
        set -g __fish_git_prompt_char_upstream_prefix ' '

        if [ $__fish_last_status -eq 0 ]
          set_color --background 5FAFAF FFFFFF
        else
          set_color --background FF6D67 FFFFFF
        end
        echo -n " $USER "
        set_color --background normal normal; echo -n " : "
        set_color AFFF00
        if [ $PWD = $HOME ]
          echo -n "~"
        else
          echo -n (basename $PWD)
        end

        printf '%s' (fish_git_prompt)

        set -lx __git_output (fish_git_prompt)
        if [ (count $__git_output) -eq 1 ]
          set -lx __git_wip (git log -n 1 | grep "\-\-wip\-\-")
          if [ (count $__git_wip) -eq 1 ]
            printf "%s WIP!!!" (set_color FF6D67)
          end
        end
      '';
      get_padding = ''
        set -l space ""
        for i in (seq 1 $argv[1])
          set space " "$space
        end
        set_color -b black
        printf $space
        set_color normal
      '';
      get_right_prompt = ''
        printf '%s[%s]' (set_color C7C7C7) (date '+%H:%M:%S')
      '';
      remove_color = ''
        printf $argv | perl -pe 's/\x1b.*?[mGKH]//g'
      '';
      home_config_apply = ''
        if test (count $argv) != 1
          echo Please provide name
          return 1
        end

        pushd .
        cd ~/.dotfiles
        gunignore ./modules/user.nix
        gwip 1> /dev/null

        nix flake update
        nix flake lock --update-input home-manager
        home-manager switch --flake ~/.dotfiles#$argv[1]

        gunwip 1> /dev/null
        gignore ./modules/user.nix
        popd
      '';
    };
  };
}
