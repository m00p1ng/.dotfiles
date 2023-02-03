{
  description = "Home Manager configuration of Mooping";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    {
      homeConfigurations.mooping = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;

        modules = [
          {
            home.stateVersion = "23.05";
            programs.home-manager.enable = true;
          }
          ./modules/bat.nix
          ./modules/browsh.nix
          ./modules/fish.nix
          ./modules/fnm.nix
          ./modules/fzf.nix
          ./modules/gh.nix
          ./modules/git.nix
          ./modules/gnu.nix
          ./modules/go.nix
          ./modules/htop.nix
          ./modules/jq.nix
          ./modules/k8s.nix
          ./modules/kitty.nix
          ./modules/less.nix
          ./modules/neovim.nix
          ./modules/python.nix
          ./modules/ripgrep.nix
          ./modules/ruby.nix
          ./modules/ssh.nix
          ./modules/tmux.nix
          ./modules/vscode.nix
          ./modules/yt-dlp.nix
          ./modules/zoxide.nix
          ({ pkgs, ... }: {
            home.packages = with pkgs; [
              awscli
              cocoapods
              curl
              fd
              gcc
              # hey     # load test
              httpie
              neofetch
              nmap
              nodePackages.pnpm
              rsync
              rustup
              smartmontools
              sqlite
              tree
              tree-sitter
              wget
              yarn
            ];
          })
        ];
      };

      homeConfigurations.mongkonchai = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;

        modules = [
          {
            home.stateVersion = "23.05";
            programs.home-manager.enable = true;
          }
          ./modules/bat.nix
          ./modules/fish.nix
          ./modules/fnm.nix
          ./modules/fzf.nix
          ./modules/git.nix
          ./modules/gh.nix
          ./modules/gnu.nix
          ./modules/go.nix
          ./modules/htop.nix
          ./modules/jq.nix
          ./modules/k8s.nix
          ./modules/kitty.nix
          ./modules/less.nix
          ./modules/neovim.nix
          ./modules/ripgrep.nix
          ./modules/ssh.nix
          ./modules/tmux.nix
          ./modules/vscode.nix
          ./modules/zoxide.nix
          ./modules/override.nix
          ({ pkgs, ... }: {
            home.packages = with pkgs; [
              curl
              fd
              gcc
              httpie
              neofetch
              smartmontools
              tree
              tree-sitter
              wget
            ];
          })
        ];
      };
    };
}
