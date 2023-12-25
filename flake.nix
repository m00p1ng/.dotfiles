# ref: https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
{
  description = "Home Manager configuration of Mooping";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, darwin, ... }: let
    mkDarwin = username: darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
        home-manager.darwinModules.home-manager
        ./modules/darwin
      ];
      specialArgs = { inherit nixpkgs home-manager username; };
    };
  in {
    darwinConfigurations = {
      m00p1ng = mkDarwin "m00p1ng";
      mongkonchai = mkDarwin "mongkonchai";
    };
  };
}
