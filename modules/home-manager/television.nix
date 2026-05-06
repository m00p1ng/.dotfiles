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
        };
        shell_integration = {
          channel_triggers= {
            brew-install = [
              "brew install"
              "brew install --cask"
            ];
          };
        };
      };

      channels = {
        brew-install = {
          metadata = {
            name = "brew-install";
            description = "A channel to install brew packages";
            requirements = [ "brew" ];
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
