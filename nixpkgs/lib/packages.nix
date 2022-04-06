{ pkgs, ... }:

{
  home.packages = with pkgs; [
    antibody
    awscli
    btop
    curl
    diff-so-fancy
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
    ripgrep
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
