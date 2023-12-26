{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.ruby;
in {
  options.programs.ruby = {
    enable = mkEnableOption "Ruby";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ruby
      pry
    ];
  };
}
