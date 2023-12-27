{ pkgs, mylib, ... }:

{
  home.stateVersion = "24.05";
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

    jq = {
      enable = true;
    };

    node = {
      enable = true;
    };

    kitty = {
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

    ripgrep = {
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

    zoxide = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    gcc
    httpie
    neofetch
    smartmontools
    pstree
    tree
    tree-sitter
    wget
  ];
}
