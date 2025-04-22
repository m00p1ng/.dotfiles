{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.television;
in {
  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    # TODO: remove this when upstream integration is available
    # ref: https://github.com/nix-community/home-manager/blob/master/modules/programs/television.nix
    programs.fish = {
      interactiveShellInit = ''
        # television configuration
        ${cfg.package}/bin/tv init fish | source
      '';
    };

    xdg.configFile.television = {
      source = ../../config/television;
      recursive = true;
    };

    programs.fzf = {
      enableFishIntegration = false;
    };
  };
}
