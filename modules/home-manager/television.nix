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
      };
    };

    programs.fzf = {
      enableFishIntegration = false;
    };

    programs.tmux.interactivePrograms = ["tv"];
  };
}
