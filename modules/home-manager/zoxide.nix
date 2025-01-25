{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.zoxide;
in {
  options.programs.zoxide = {
    excludeDirs = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      _ZO_EXCLUDE_DIRS = concatStringsSep ":" (["\$HOME"] ++ cfg.excludeDirs);
    };
  };
}
