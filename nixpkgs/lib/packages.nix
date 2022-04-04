{ pkgs, ... }:

{
  home.packages = with pkgs; [
    antibody
    awscli
    bat
    btop
    curl
    diff-so-fancy
    fzf
    gcc
    gh
    git
    hey     #load test
    httpie
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
    wget
    yarn
    youtube-dl
    zsh
  ];
}
