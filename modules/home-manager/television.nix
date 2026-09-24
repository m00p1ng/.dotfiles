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
            brew-packages = [
              "brew uninstall"
            ];
            alias = [
              "alias"
              "unalias"
            ];
            env = [
              "export"
              "unset"
            ];
            dirs = [
              "cd"
              "ls"
              "rmdir"
              "z"
            ];
            files = [
              "cat"
              "less"
              "head"
              "tail"
              "vim"
              "nvim"
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
              "nvim"
            ];
            git-diff = [
              "git add"
              "git restore"
            ];
            git-branch = [
              "git checkout"
              "git switch"
              "git branch"
              "git merge"
              "git rebase"
              "git pull"
              "git push"

              # git town
              "git town delete"
              "git delete"
            ];
            git-log = [
              "git log"
              "git show"
            ];
            docker-images = [
              "docker run"
            ];
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
              {
                name = "All";
                run = "{ brew formulae; brew casks; }";
              }
              {
                name = "Formulae";
                run = "brew formulae";
              }
              {
                name = "Casks";
                run = "brew casks";
              }
            ];
            ansi = true;
          };
          ui = {
            layout = "landscape";
          };
          preview = {
            command = "HOMEBREW_COLOR=1 brew info '{}'";
          };
        };
      };
    };

    programs.tmux.interactivePrograms = ["tv"];

    programs.nix-search-tv.enableTelevisionIntegration = true;
  };
}
