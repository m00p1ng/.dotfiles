{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    k9s
    stern
  ];

  home.sessionVariables = {
    "K9SCONFIG" = "${config.xdg.configHome}/k9s";
  };

  xdg.configFile.k9s = {
    source = ../configs/k9s;
    recursive = true;
  };
}
