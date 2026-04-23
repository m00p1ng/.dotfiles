{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.gh;
in {
  config = mkIf cfg.enable {
    programs.gh = {
      settings = {
        version = "1";
      };
    };

    programs.git = {
      settings = {
        alias = {
          pr = "!gh pr create --web";
        };
      };
    };
  };
}
