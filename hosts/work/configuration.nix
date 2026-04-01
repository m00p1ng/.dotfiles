{
  nixpkgs,
  username,
  ...
}: let
  inherit (nixpkgs) lib;
  mylib = import ../../lib {inherit lib;};
in {
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager = {
    users.${username} = import ./home.nix;
    extraSpecialArgs = {inherit mylib;};
  };

  services = {
    sketchybar = {
      enable = true;
      widget = {
        slack = true;
        meeting = {
          enable = true;
        };
      };
    };

    yabai = {
      enable = true;
    };
  };
}
