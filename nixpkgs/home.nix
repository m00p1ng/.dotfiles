{ config, pkgs, ... }:

{
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./config/packages.nix
    ./config/user.nix
    ./config/git.nix
    ./config/bat.nix
    ./config/ripgrep.nix
    ./config/ssh.nix
  ];
}
