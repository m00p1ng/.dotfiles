{ nixpkgs, username, ... }:

let
  inherit (nixpkgs) lib;
  mylib = import ../../lib { inherit lib; };
in {
  home-manager = {
    users.${username} = import ./home.nix;
    extraSpecialArgs = { inherit mylib; };
  };
}
