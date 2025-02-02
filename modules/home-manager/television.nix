{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.television;
in {
  options.programs.television = {
    enable = mkEnableOption "television";
    package = mkOption {
      type = types.package;
      default = pkgs.television;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.fish = {
      interactiveShellInit = ''
        # television configuration
        ${cfg.package}/bin/tv init fish | source
      '';
    };

    programs.fzf = {
      enableFishIntegration = false;
    };
  };
}
