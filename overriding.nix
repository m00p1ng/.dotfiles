{ pkgs, lib, ... }:

with lib;
{
  home.packages = with pkgs; [
  ];

  programs.git = {
    userName = "<git username>";
    userEmail = "<git email>";
  };
}
