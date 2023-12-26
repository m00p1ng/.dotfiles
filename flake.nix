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

  outputs = { nixpkgs, home-manager, darwin, ... }:
  let
    inherit (nixpkgs) lib;
    mylib = import ./lib { inherit lib; };
  in
  {
    darwinConfigurations = {
      mooping = let
        username = "m00p1ng";
      in darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit username; };
        modules = [
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.${username} = import ./hosts/m00p1ng/home.nix;
              extraSpecialArgs = { inherit mylib; };
            };
          }
          ./modules/darwin
          ./overriding.nix
        ];
      };

      mongkonchai = let
        username = "mongkonchai";
      in darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit username; };
        modules = [
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.${username} = import ./hosts/mongkonchai/home.nix;
              extraSpecialArgs = { inherit mylib; };
            };
          }
          ./modules/darwin
          ./overriding.nix
        ];
      };
    };
  };
}
