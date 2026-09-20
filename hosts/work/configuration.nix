{
  nixpkgs,
  username,
  pkgs,
  ...
}: let
  inherit (nixpkgs) lib;
  mylib = import ../../lib {
    inherit lib pkgs;
  };
in {
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager = {
    users.${username} = import ./home.nix;
    extraSpecialArgs = {inherit mylib;};
  };

  homebrew = {
    enable = true;
    brews = [
      "mole"
      "raine/workmux/workmux"
    ];

    casks = [
      "google-chrome"

      "flux-app"
      "coconutbattery"
      # "raycast"
      "vicinae"
      "1password"
      # "1password-cli"
      "atoll"

      "notion"

      # "postman"
      "bruno"

      "ghostty"
      "zed"

      "chatgpt"
      # "google-gemini"
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
        volume = true;
      };
    };

    yabai = {
      enable = true;
    };
  };
}
