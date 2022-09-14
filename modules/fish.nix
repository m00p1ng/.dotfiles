{ config, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx EDITOR nvim

      source ${config.xdg.configHome}/myfish/theme.fish
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
      gcount = "git shortlog -sn";

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

  xdg.configFile.myfish = {
    source = ../configs/fish;
    recursive = true;
  };
}
