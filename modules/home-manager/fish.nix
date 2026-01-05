{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.fish;
in {
  config = mkIf cfg.enable {
    programs.fish = {
      shellAliases = mkMerge [
        {
          "..." = "cd ../..";
          "...." = "cd ../../..";
          mv = "mv -i";

          isodate = "date +%Y-%m-%d";
          isodatetime = "date +\"%Y-%m-%dT%H:%M:%S\"";

          # network
          ip = "curl api.ipify.org";
        }

        (mkIf pkgs.stdenv.hostPlatform.isDarwin {
          watchdns = "sudo tcpdump -vvi any port 53";
          cleardns = "sudo killall -HUP mDNSResponder";
          wifi-network-name = "ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}'";
          wifi-password = "security find-generic-password -wa (wifi-network-name)";
          wifi-reset = "networksetup -setairportpower en0 off && networksetup -setairportpower en0 on";
          check_disk = "sudo smartctl --all /dev/disk0s1";

          showfiles = "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";
          hidefiles = "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";
          icloud = "cd ~/Library/Mobile\\ Documents/com\~apple\~CloudDocs";
        })
      ];
      shellAbbrs = {
        "-" = "cd -"; # abbr -a -- - 'cd -'
      };
      shellInit = ''
        fish_add_path ~/.nix-profile/bin
        fish_add_path /nix/var/nix/profiles/default/bin
        fish_add_path ~/.local/bin
        ${optionalString pkgs.stdenv.hostPlatform.isDarwin ''
          fish_add_path /run/current-system/sw/bin
        ''}
      '';
      interactiveShellInit = ''
        bind \ep history-token-search-backward
        bind \en history-token-search-forward

        fish_config theme choose mooping
      '';
      plugins = [
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
      source = ../../config/fish/main;
      recursive = true;
    };

    xdg.configFile."fish/macos" = mkIf pkgs.stdenv.hostPlatform.isDarwin {
      source = ../../config/fish/helper/macos;
      recursive = true;
      onChange = ''
        run mv ${config.xdg.configHome}/fish/macos/* ${config.xdg.configHome}/fish/functions
        run rmdir ${config.xdg.configHome}/fish/macos
      '';
    };
  };
}
