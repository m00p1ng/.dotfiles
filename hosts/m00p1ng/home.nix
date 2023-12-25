{ pkgs, ... }:
{
  home.stateVersion = "24.05";
  imports = [
    ../../modules/home-manager/bat.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/fnm.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/gh.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/gnu.nix
    ../../modules/home-manager/go.nix
    ../../modules/home-manager/htop.nix
    ../../modules/home-manager/jq.nix
    ../../modules/home-manager/k8s.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/less.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/pnpm.nix
    ../../modules/home-manager/python.nix
    ../../modules/home-manager/ripgrep.nix
    ../../modules/home-manager/ruby.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/yt-dlp.nix
    ../../modules/home-manager/zoxide.nix
    ../../overriding.nix
  ];

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
