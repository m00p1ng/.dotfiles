{ pkgs, username, ... }:

{
  imports = [
    ../common.nix
    ./pam.nix # enableSudoTouchIdAuth is now in nix-darwin, but without the reattach stuff for tmux
    ./core.nix
    ./preferences.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # `home-manager` config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    users.${username} = import ../../hosts/${username}/home.nix;
    extraSpecialArgs = { inherit pkgs; };
  };
}
