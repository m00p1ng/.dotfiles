{ config, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      "..." = "cd ../..";
      vim = "nvim";
      mv = "mv -i";
      gc = "git commit";
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
      gpf = "git push --force-with-lease";
      gpo = "git push -u origin HEAD";
    };
    interactiveShellInit = ''
      bind \ep history-token-search-backward
      bind \en history-token-search-forward
    '';
  };

  xdg.configFile."fish" = {
    source = ../configs/fish;
    recursive = true;
  };
}
