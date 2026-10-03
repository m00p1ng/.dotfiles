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
      "raine/workmux/workmux"
      "codeburn"

      "yutat23/tap/lsoff"
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

      "codex"
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
        codeburn = true;
      };
    };

    yabai = {
      enable = true;
    };
  };
}
