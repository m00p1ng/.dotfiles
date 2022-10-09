{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    coreutils
    gnused
    gawk
  ];
}
