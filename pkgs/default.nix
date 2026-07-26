{
  nixpkgs.config.packageOverrides = pkgs: {
    icalBuddy = pkgs.callPackage ./icalBuddy/package.nix {};
    icalPal = pkgs.callPackage ./icalPal/package.nix {};
  };
}
