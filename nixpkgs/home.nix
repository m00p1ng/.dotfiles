{ config, pkgs, ... }:

{
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./lib/packages.nix
    ./lib/user.nix
    ./lib/git.nix
    ./lib/bat.nix
  ];
}
