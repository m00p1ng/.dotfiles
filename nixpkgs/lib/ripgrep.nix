{ pkgs, lib, ... }:

let
  configFilePath = "ripgrep/ripgrep-config.txt";
  user = import ./user.nix;
in {
  home.packages = with pkgs; [
    ripgrep
  ];

  home.sessionVariables = {
    "RIPGREP_CONFIG_PATH" = "${user.xdg.configHome}/${configFilePath}";
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
