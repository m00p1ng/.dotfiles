{ pkgs, config, ... }:

let
  configFilePath = "ripgrep/.ripgreprc";
in {
  home.packages = with pkgs; [
    ripgrep
  ];

  home.sessionVariables = {
    "RIPGREP_CONFIG_PATH" = "${config.xdg.configHome}/${configFilePath}";
  };

  xdg.configFile."${configFilePath}" = {
    source = ../configs/ripgrep;
    recursive = true;
  };
}
