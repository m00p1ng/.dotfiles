{username, ...}: {
  imports = [
    ../common.nix
    ./pam.nix # enableSudoTouchIdAuth is now in nix-darwin, but without the reattach stuff for tmux
    ./core.nix
    ./preferences.nix

    # services
    ./sketchybar.nix
    ./yabai.nix
    ./skhd.nix
  ];

  system.primaryUser = username;
  nixpkgs.config.allowUnfree = true;

  # `home-manager` config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
  };
}
