{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      "..." = "cd ../..";
      vim = "nvim";
      mv = "mv -i";

      # git
      gc = "git commit";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      glg = "git log --stat";
      glgp = "git log --stat -p";
      gwip = "git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m \"--wip-- [skip ci]\"";
      gunwip = "git log -n 1 | grep -q -c -e \"--wip--\" && git reset HEAD~1";
      gignore = "git update-index --skip-worktree";
      gignored = "git ls-files -v | grep \"^S\"";
      gunignore = "git update-index --no-skip-worktree";
      gcount = "git shortlog -sn";

      s = "kitty +kitten ssh";
      check_disk = "sudo smartctl --all /dev/disk0s1";
      isodate = "date +%Y-%m-%d";
      isodatetime = "date +\"%Y-%m-%dT%H:%M:%S\"";

      # network
      ip = "curl api.ipify.org";
      watchdns = "sudo tcpdump -vvi any port 53";
      cleardns = "sudo killall -HUP mDNSResponder";
      wifi-network-name = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'";
      wifi-password = "security find-generic-password -wa (wifi-network-name)";
      wifi-reset = "networksetup -setairportpower en0 off && networksetup -setairportpower en0 on";

      # macos
      showfiles = "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";
      hidefiles = "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";
      icloud = "cd ~/Library/Mobile\\ Documents/com\~apple\~CloudDocs";
    };
    shellAbbrs = {
      g = "git";
      gl = "git pull";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gpo = "git push -u origin HEAD";
      gco = "git checkout";
      "-" = "cd -"; # abbr -a -- - 'cd -'
    };
    shellInit = ''
      fish_add_path ~/.nix-profile/bin
      fish_add_path /nix/var/nix/profiles/default/bin
      fish_add_path /run/current-system/sw/bin
    '';
    interactiveShellInit = ''
      bind \ep history-token-search-backward
      bind \en history-token-search-forward

      for f in ${config.xdg.configHome}/fish/functions/macos/*.fish
        source $f
      end
    '';
    plugins = with pkgs; [
      # {
      #   name = "fish-functions";
      #   src = fetchFromGitHub {
      #     owner = "razzius";
      #     repo = "fish-functions";
      #     rev = "11dea7268cecd25d8ec17862917d5dba338af5eb";
      #     hash = "sha256-eyDZaZlqtRPhn08tTFYXthkMhVFX0yN6eXIOMoS6RWk=";
      #   };
      # }
    ];
  };

  xdg.configFile."fish" = {
    source = ../configs/fish;
    recursive = true;
  };
}
