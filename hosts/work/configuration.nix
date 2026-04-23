{
  nixpkgs,
  username,
  ...
}: let
  inherit (nixpkgs) lib;
  mylib = import ../../lib {
    inherit lib;
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  };
in {
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager = {
    users.${username} = import ./home.nix;
    extraSpecialArgs = {inherit mylib;};
  };

  homebrew = {
    enable = true;
    casks = [
      "google-chrome"

      "flux-app"
      "coconutbattery"
      "raycast"
      "1password"

      "notion"

      # "postman"
      "bruno"

      "ghostty"

      "google-gemini"
    ];
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
