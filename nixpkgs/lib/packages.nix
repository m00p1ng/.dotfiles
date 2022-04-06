{ pkgs, ... }:

{
  home.packages = with pkgs; [
    antibody
    awscli
    btop
    curl
    fd
    fzf
    gcc
    gh
    gnused
    go
    hey     #load test
    httpie
    jq
    less
    neovim
    nmap
    nodejs
    python3
    python39Packages.pip
    rsync
    ruby
    sqlite
    tmux
    tree
    tree-sitter
    wget
    yarn
    youtube-dl
    zsh
  ];
}
