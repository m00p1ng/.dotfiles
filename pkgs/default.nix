{
  nixpkgs.config.packageOverrides = pkgs: {
    icalBuddy = pkgs.callPackage ./icalBuddy/package.nix {};
  };
}
