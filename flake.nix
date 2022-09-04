{
  description = "Home Manager configuration of Mooping";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      config = import ./modules/user.nix;
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    in
    {
      homeConfigurations.mooping = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            home = {
              stateVersion = "22.11";
              homeDirectory = config.home.path;
              username = config.home.username;
            };
            programs.home-manager.enable = true;
            programs.git = {
              userName = config.git.username;
              userEmail = config.git.email;
            };
          }
          ./modules/bat.nix
          ./modules/fish.nix
          ./modules/fzf.nix
          ./modules/git.nix
          ./modules/go.nix
          ./modules/ripgrep.nix
          ./modules/ssh.nix
          ./modules/tmux.nix
          ./modules/zoxide.nix
          {
            home.packages = with pkgs; [
              awscli
              cocoapods
              coreutils
              curl
              fd
              fnm
              gcc
              gh
              gnused
              hey     # load test
              htop
              jq
              kubectl
              less
              minikube
              neovim
              nmap
              nodejs
              python3
              rsync
              ruby
              rustup
              smartmontools
              sqlite
              stow
              tree
              tree-sitter
              wget
              youtube-dl
            ];
          }
        ];
      };

      homeConfigurations.mongkonchai = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            home = {
              stateVersion = "22.11";
              homeDirectory = config.home.path;
              username = config.home.username;
            };
            programs.home-manager.enable = true;
            programs.git = {
              userName = config.git.username;
              userEmail = config.git.email;
            };
          }
          ./modules/bat.nix
          ./modules/fish.nix
          ./modules/fzf.nix
          ./modules/git.nix
          ./modules/ripgrep.nix
          ./modules/ssh.nix
          ./modules/tmux.nix
          ./modules/zoxide.nix
          {
            home.packages = with pkgs; [
              coreutils
              curl
              fd
              fnm
              gcc
              gh
              gnused
              htop
              jq
              less
              neovim
              nodejs
              smartmontools
              tree
              tree-sitter
            ];
          }
        ];
      };
    };
}
