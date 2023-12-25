{ pkgs, lib, ... }:
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  fonts.fontDir.enable =
    true; # if this is true, manually installed system fonts will be deleted!
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  # allow touchid to auth sudo -- this comes from pam.nix, which needs to be loaded before this
  # it's now standard to nix-darwin, but without the special such needed for tmux, so we
  # will continue using our custom script
  security.pam.enableCustomSudoTouchIdAuth = true;
  # security.pam.enableSudoTouchIdAuth = true;
}
