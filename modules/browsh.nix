{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    browsh
  ];

  # xdg.configFile."browsh/config.toml".text = ''
  # '';
}
