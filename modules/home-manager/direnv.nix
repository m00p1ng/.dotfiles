{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.direnv;
in {
  config = mkIf cfg.enable {
    programs.direnv = {
      nix-direnv.enable = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };

    xdg.configFile.direnv = {
      source = ../../config/direnv;
      recursive = true;
    };
  };
}
