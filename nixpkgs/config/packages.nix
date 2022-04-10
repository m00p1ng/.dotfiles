{ pkgs, ... }:

let
  packages = with pkgs; [
    btop
    coreutils
    curl
    fd
    gcc
    gh
    gnused
    jq
    less
    neovim
    nodejs
    sqlite
    stow
    tmux
    tree
    tree-sitter
    yarn
  ];
  optionalPackage = with pkgs; [
    awscli
    go
    hey     #load test
    httpie
    nmap
    python3
    rsync
    ruby
    rustup
    wget
    youtube-dl
    zsh
  ];
in
{
  home.packages = with pkgs; packages
    # ++ optionalPackage
  ;
}
