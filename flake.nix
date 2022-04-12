{
  description = "Home Manager configuration of Mooping";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, ... }:
    let
      config = import ./modules/user.nix;
    in
    {
      homeConfigurations.mooping = home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        stateVersion = "22.05";
        homeDirectory = config.home.path;
        username = config.home.username;

        configuration = { pkgs, ... }: {
          programs.git = {
            userName = config.git.username;
            userEmail = config.git.email;
          };

          imports = [
            ./modules/packages.nix
          ];
        };
      };
    };
}
