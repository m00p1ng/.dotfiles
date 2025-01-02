{
  pkgs,
  mylib,
  ...
}: {
  home.stateVersion = "24.05";
  imports = mylib.scanPaths ../../modules/home-manager;

  programs = {
    bat = {
      enable = true;
    };

    eza = {
      enable = true;
    };

    fish = {
      enable = true;
    };

    fzf = {
      enable = true;
    };

    gh = {
      enable = true;
    };

    ghostty-config = {
      enable = true;
    };

    git = {
      enable = true;
      delta = {
        enable = true;
      };
    };

    go = {
      enable = true;
    };

    htop = {
      enable = true;
    };

    jq = {
      enable = true;
    };

    kubernetes = {
      enable = true;
      stern = {
        enable = true;
      };
      k9s = {
        enable = true;
      };
    };

    node = {
      enable = true;
      pnpm = {
        enable = true;
      };
    };

    python = {
      enable = true;
      poetry = {
        enable = true;
      };
    };

    ripgrep = {
      enable = true;
    };

    ruby = {
      enable = true;
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          identityFile = "~/.ssh/mooping-macbook";
        };
      };
    };

    thefuck = {
      enable = true;
    };

    tmux = {
      enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    yt-dlp = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    gcc
    # hey     # load test
    htop
    httpie
    fastfetch
    imagemagick
    rsync
    # rustup
    smartmontools
    sqlite
    tree
    tree-sitter
    wget

    nixd
    alejandra
  ];
}
