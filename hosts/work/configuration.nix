{
  nixpkgs,
  username,
  ...
}: let
  inherit (nixpkgs) lib;
  mylib = import ../../lib {inherit lib;};
in {
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
      bar.height = 32;
    };

    yabai = {
      enable = true;
    };
  };
}
