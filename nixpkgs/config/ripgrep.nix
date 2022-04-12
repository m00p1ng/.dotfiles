{ pkgs, ... }:

let
  configFilePath = "ripgrep/ripgrep-config.txt";
  config = import ./xdg.nix;
in {
  home.packages = with pkgs; [
    ripgrep
  ];

  home.sessionVariables = {
    "RIPGREP_CONFIG_PATH" = "${config.xdg.configHome}/${configFilePath}";
  };

  xdg.configFile."${configFilePath}".text = ''
    --type-add
    web:*.{html,css,js}*

    --colors=line:fg:yellow
    --colors=line:style:bold

    --colors=path:fg:green
    --colors=path:style:bold

    --glob=!git/*
    --hidden
  '';

}
