{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.python;
  pythonEnv = pkgs.python311.withPackages (ps: [
    ps.ipython
    ps.pip
    ps.pynvim
  ]);
in {
  options.programs.python = {
    enable = mkEnableOption "python";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pythonEnv
    ];
  };
}
