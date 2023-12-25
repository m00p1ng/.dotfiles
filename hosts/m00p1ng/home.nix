{ pkgs, lib, ... }:

with lib;
{
  home.stateVersion = "24.05";
  imports = [
    # ../../modules/home-manager/fnm.nix
    # ../../modules/home-manager/gnu.nix
    # ../../modules/home-manager/k8s.nix
    # ../../modules/home-manager/kitty.nix
    # ../../modules/home-manager/less.nix
    # ../../modules/home-manager/neovim.nix
    # ../../modules/home-manager/pnpm.nix
    # ../../modules/home-manager/python.nix
    # ../../modules/home-manager/ruby.nix
    ../../modules/home-manager
    ../../overriding.nix
  ];

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
