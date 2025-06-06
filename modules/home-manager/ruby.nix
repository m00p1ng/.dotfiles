{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.ruby;
  rubyEnv = pkgs.ruby.withPackages (ps:
    with ps; [
      pry
    ]);
in {
  options.programs.ruby = {
    enable = mkEnableOption "Ruby";
  };

  config = mkIf cfg.enable {
    home.packages = [
      rubyEnv
    ];
  };
}
