{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.television;
in {
  config = mkIf cfg.enable {
    # TODO: remove this when upstream integration is available
    # ref: https://github.com/nix-community/home-manager/blob/master/modules/programs/television.nix
    programs.fish = {
      interactiveShellInit = ''
        # television configuration
        ${cfg.package}/bin/tv init fish | source
      '';
    };
    programs.television = {
      enableFishIntegration = false;
      settings = {
        ui = {
          theme = "catppuccin";
          status_bar = {
            hidden = false;
          };
        };
        shell_integration = {
          channel_triggers = {
            brew-install = [
              "brew install"
              "brew install --cask"
            ];
            alias = ["alias" "unalias"];
            env = ["export" "unset"];
            dirs = ["cd" "ls" "rmdir" "z"];
            files = [
              "cat"
              "less"
              "head"
              "tail"
              "vim"
              "nano"
              "bat"
              "cp"
              "mv"
              "rm"
              "touch"
              "chmod"
              "chown"
              "ln"
              "tar"
              "zip"
              "unzip"
              "gzip"
              "gunzip"
              "xz"
            ];
            "git-diff" = ["git add" "git restore"];
            "git-branch" = [
              "git checkout"
              "git switch"
              "git branch"
              "git merge"
              "git rebase"
              "git pull"
              "git push"
            ];
            "git-log" = ["git log" "git show"];
            "docker-images" = ["docker run"];
            "git-repos" = ["nvim" "code" "hx" "git clone"];
          };
        };
      };

      channels = {
        brew-install = {
          metadata = {
            name = "brew-install";
            description = "A channel to install brew packages";
            requirements = ["brew"];
          };
          source = {
            command = [
              "brew formulae"
              "brew casks"
            ];
          };
          preview = {
            command = "HOMEBREW_COLOR=1 brew info '{}'";
          };
        };
      };
    };

    programs.fzf = {
      enableFishIntegration = false;
    };

    programs.tmux.interactivePrograms = ["tv"];
  };
}
