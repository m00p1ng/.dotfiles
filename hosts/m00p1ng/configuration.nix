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
    enable = false;
    casks = [
       "google-chrome"
       "firefox"

       "flux"
       "coconutbattery"
       "alfred"
       "1password"

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
