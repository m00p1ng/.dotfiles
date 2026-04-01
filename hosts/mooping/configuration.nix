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

  homebrew = {
    enable = false;
    casks = [
      "google-chrome"
      "firefox"

      "flux-app"
      "coconutbattery"
      "raycast"
      "1password"

      "notion"
      "discord"
      "sf-symbols"
      "grammarly-desktop"

      # "postman"
      "bruno"

      # "docker-desktop"
      "orbstack"

      "ghostty"

      "vlc"
    ];

    masApps = {
      "Xcode" = 497799835;
      "1Password for Safari" = 1569813296;
      "Grammarly for Safari" = 1462114288;

      "Pages" = 361309726;
      "Numbers" = 361304891;
      "Keynote" = 361285480;

      "PDF Expert" = 1055273043;
      "Kindle" = 302584613;
      "GoodLinks" = 1474335294;
      "Bear" = 1091189122;

      "LINE" = 539883307;
      "Spark" = 1176895641;
      "Fantastical" = 975937182;

      "PiPifier" = 1160374471;
      "Money Pro" = 972572731;
    };
  };

  services = {
    sketchybar = {
      enable = false;
      widget = {
        currency = true;
      };
    };

    yabai = {
      enable = false;
    };
  };
}
