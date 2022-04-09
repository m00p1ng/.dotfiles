{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      mv = "mv -i";
      gl = "git pull";
      gp = "git push";
      gpo = "git push -u origin HEAD";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      glg = "git log --stat";
      glgp = "git log --stat -p";
      gwip = "git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m \"--wip-- [skip ci]\"";
      gunwip = "git log -n 1 | grep -q -c \"\-\-wip\-\-\" && git reset HEAD~1";
      gignore = "git update-index --assume-unchanged";
      gignored = "git ls-files -v | grep \"^[[:lower:]]\"";
      gunignore = "git update-index --no-assume-unchanged";

      showfiles = "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";
      hidefiles = "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";
      icloud = "cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs";
    };
    shellAbbrs = {
      g = "git";
      gff = "git fuzzy";
    };
    functions = {
      fish_prompt = ''
        set -l last_pipestatus $pipestatus
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

        echo
        if [ $last_pipestatus -eq 0 ]
          set_color --background 5FAFAF FFFFFF
        else
          set_color --background FF6D67 FFFFFF
        end
        echo -n " $USER "
        set_color --background normal normal; echo -n " : "
        set_color AFFF00; echo -n (prompt_pwd)

        printf '%s' (fish_vcs_prompt)

        # traffic light arrow
        printf "\n%s▶%s▶%s▶ " (set_color FF6D67) (set_color FEFB67) (set_color 56FF5F)
      '';
      fish_right_prompt = ''
        printf '%s[%s]' (set_color C7C7C7) (date '+%H:%M:%S')
      '';
    };
  };
}
