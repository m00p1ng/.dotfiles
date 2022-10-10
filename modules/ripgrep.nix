{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    ripgrep
  ];

  home.sessionVariables = {
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/.ripgreprc";
  };

  xdg.configFile."ripgrep/.ripgreprc".text = ''
    --type-add
    web:*.{html,css,scss,sass,vue,js,jsx,ts,tsx}*

    --colors=line:fg:yellow
    --colors=line:style:bold

    --colors=path:fg:green
    --colors=path:style:bold

    --glob=!.git/*
    --hidden
  '';
}
