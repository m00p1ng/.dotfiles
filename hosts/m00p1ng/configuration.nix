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
       "alfred"
       "1password"
       "setapp"

       "notion"
       "zoom"
       "discord"
       "sf-symbols"

       "postman"
       "docker"

       "vlc"
    ];
  };

  services = {
    sketchybar = {
      enable = true;
    };

    yabai = {
      enable = true;
    };

    skhd = {
      enable = true;
    };
  };
}
