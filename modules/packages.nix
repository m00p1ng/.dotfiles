{ pkgs, ... }:

let
  config = import ./user.nix;
  main-packages = with pkgs; [
    btop
    coreutils
    curl
    fd
    fnm
    gcc
    gh
    gnused
    jq
    less
    neovim
    nodejs
    sqlite
    stow
    tree
    tree-sitter
  ];
  opt-packages = with pkgs; [
    awscli
    go
    hey     #load test
    httpie
    nmap
    python3
    rsync
    ruby
    rustup
    smartmontools
    wget
    youtube-dl
  ];
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./git.nix
    ./bat.nix
    ./ripgrep.nix
    ./ssh.nix
    ./fish.nix
    ./zoxide.nix
    ./fzf.nix
    ./tmux.nix
  ];

  home.packages = if config.installOptional then
    main-packages ++ opt-packages
  else
    main-packages;
}
