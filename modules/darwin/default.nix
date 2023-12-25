{ pkgs, ... }: {
  imports = [
    ./pam.nix # enableSudoTouchIdAuth is now in nix-darwin, but without the reattach stuff for tmux
    ./core.nix
    ./preferences.nix
  ];
}
