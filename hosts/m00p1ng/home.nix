{ pkgs, mylib, ... }:

{
  home.stateVersion = "24.05";
  # ../../modules/home-manager/k8s.nix
  imports = mylib.scanPaths ../../modules/home-manager;

  programs = {
    bat = {
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

    kitty = {
      enable = true;
    };

    node = {
      enable = true;
      pnpm = {
        enable = true;
      };
    };

    python = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    ruby = {
      enable = true;
    };

    ssh = {
      enable = true;
    };

    tmux = {
      enable = true;
    };

    vscode = {
      enable = true;
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
    httpie
    neofetch
    rsync
    # rustup
    smartmontools
    sqlite
    tree
    tree-sitter
    wget
  ];
}
