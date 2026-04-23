{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.fish;
in {
  config = mkIf (cfg.enable && pkgs.stdenv.hostPlatform.isDarwin) {
    programs.fish = {
      shellAliases = {
        watchdns = "sudo tcpdump -vvi any port 53";
        cleardns = "sudo killall -HUP mDNSResponder";
        wifi-network-name = "ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}'";
        wifi-password = "security find-generic-password -wa (wifi-network-name)";
        wifi-reset = "networksetup -setairportpower en0 off && networksetup -setairportpower en0 on";
        smartmon = "sudo smartctl -a /dev/disk0";

        showfiles = "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";
        hidefiles = "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";
        icloud = "cd ~/Library/Mobile\\ Documents/com\~apple\~CloudDocs";
        nix-diff = "nvd diff (command ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
      };

      shellInit = ''
        fish_add_path /run/current-system/sw/bin

        # Homebrew completions
        if test -d (brew --prefix)"/share/fish/completions"
          set -p fish_complete_path (brew --prefix)/share/fish/completions
        end

        if test -d (brew --prefix)"/share/fish/vendor_completions.d"
          set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
        end
      '';

      interactiveShellInit = ''
        complete -c darwin-apply -n "__fish_use_subcommand" -f -a "mooping work"
      '';

      functions = {
        darwin-apply = {
          description = "nix-darwin wrapper";
          body = ''
            set -l script (path dirname (path dirname (status -f)))/scripts/darwin-apply.py
            python3 $script $argv
          '';
        };
        cdf = "cd (pfd)";
        colorpicker = ''
          set rgb (osascript -e 'choose color' | string split ,)
          for color in $rgb
            printf %02x (math round $color / (printf %d 0x101))
          end
        '';
        folder-icon = ''
          if test (count $argv) -ne 2
            echo "Usage: folder-icon <icon-name> <folder-path>"
            echo "Example: folder-icon 'camera.viewfinder' '/path/to/folder'"
            return 1
          end

          xattr -w 'com.apple.icon.folder#S' "{\"sym\":\"$argv[1]\"}" $argv[2]
        '';
        lock = "osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down, control down}'";
        logout = "osascript -e 'tell application \"loginwindow\" to  «event aevtrlgo»'";
        man-preview = {
          body = "mandoc -Tpdf (man -w $cmd) | open -f -a Preview";
          argumentNames = "cmd";
          description = "Open man page as PDF in Preview";
        };
        pfd = ''
          osascript 2>/dev/null -e '
            tell application "Finder"
              return POSIX path of (insertion location as alias)
            end tell
          '
        '';
      };
    };
  };
}
