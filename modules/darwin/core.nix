{ pkgs, lib, ... }:
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # allow touchid to auth sudo -- this comes from pam.nix, which needs to be loaded before this
  # it's now standard to nix-darwin, but without the special such needed for tmux, so we
  # will continue using our custom script
  security.pam.enableCustomSudoTouchIdAuth = true;
  # security.pam.enableSudoTouchIdAuth = true;
}
