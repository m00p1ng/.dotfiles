{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    ripgrep
  ];

  home.sessionVariables = {
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/.ripgreprc";
  };

  xdg.configFile."ripgrep/.ripgreprc" = {
    source = ../configs/ripgrep/.ripgreprc;
  };
}
