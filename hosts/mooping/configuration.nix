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
      "kimi-code"
      "mole"
    ];

    casks = [
      "google-chrome"
      "firefox"

      "flux-app"
      "coconutbattery"
      "raycast"
      "1password"
      "puremac"

      "notion"
      "discord"
      "sf-symbols"
      "grammarly-desktop"
      "tolaria"

      # "postman"
      "bruno"

      # "docker-desktop"
      "orbstack"

      "ghostty"
      "zed"

      "vlc"

      # "antigravity"
      # "chatgpt"
      # "codex-app"
      "claude"
      # "google-gemini"
      "kimi"
      "lm-studio"
      "ollama-app"
      # "opencode-desktop"
      # "steipete/tap/codexbar"
    ];

    # NOTE: https://github.com/nix-darwin/nix-darwin/issues/1722
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
      "Spark Desktop" = 6445813049;
      # "Fantastical" = 975937182;

      "PiPifier" = 1160374471;
      "Money Pro" = 972572731;

      "Draw Things" = 6444050820;
    };
  };

  services = {
    sketchybar = {
      enable = true;
      widget = {
        currency = true;
        nixpkgs = true;
      };
    };

    yabai = {
      enable = true;
    };
  };
}
