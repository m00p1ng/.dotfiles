{ pkgs, ... }:

let
  packages = with pkgs; [
    antibody
    btop
    coreutils
    curl
    fd
    fzf
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
    zsh
  ];
  optionalPackage = with pkgs; [
    awscli
    go
    hey     #load test
    httpie
    nmap
    python3
    python39Packages.pip
    rsync
    ruby
    rustup
    wget
    youtube-dl
  ];
in
{
  home.packages = with pkgs; packages
    # ++ optionalPackage
  ;
}
