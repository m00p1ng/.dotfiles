{
  nixpkgs.config.packageOverrides = pkgs: {
    icalBuddy = pkgs.callPackage ./icalBuddy/package.nix {};
    icalPal = pkgs.callPackage ./icalPal/package.nix {};

    # rtk 0.43.0 upstream has dead code that fails `-D warnings` when
    # compiling the test binary. Skip checks until fixed upstream.
    rtk = pkgs.rtk.overrideAttrs (_: {
      doCheck = false;
    });
  };
}
