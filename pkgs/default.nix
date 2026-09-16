{
  nixpkgs.config.packageOverrides = pkgs: {
    ical-guy = pkgs.callPackage ./ical-guy/package.nix {};

    # rtk 0.43.0 upstream has dead code that fails `-D warnings` when
    # compiling the test binary. Skip checks until fixed upstream.
    rtk = pkgs.rtk.overrideAttrs (_: {
      doCheck = false;
    });
  };
}
