{ nixpkgs, username, ... }:

let
  inherit (nixpkgs) lib;
  mylib = import ../../lib { inherit lib; };
in {
  home-manager = {
    users.${username} = import ./home.nix;
    extraSpecialArgs = { inherit mylib; };
  };

  homebrew = {
    enable = true;
    casks = [
       "google-chrome"
       "firefox"

       "flux"
       "coconutbattery"
       "raycast"
       "1password"
       "setapp"

       "notion"
       "zoom"
       "discord"
       "sf-symbols"
       "grammarly-desktop"

       "postman"
       "docker"
       "ghostty"

       "vlc"
    ];

    masApps = {
      "Xcode" = 497799835;
      "1Password for Safari" = 1569813296;
      "Grammarly for Safari" = 1462114288;

      "Pages" = 409201541;
      "Numbers" = 409203825;
      "Keynote" = 409183694;

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
      enable = true;
    };

    yabai = {
      enable = true;
      config.external_bar = "all:28:0";
    };
  };
}
