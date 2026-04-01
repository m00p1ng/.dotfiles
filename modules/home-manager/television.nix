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

    xdg.configFile.television = {
      source = ../../config/television;
      recursive = true;
    };

    programs.fzf = {
      enableFishIntegration = false;
    };
  };
}
