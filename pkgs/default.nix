{
  nixpkgs.config.packageOverrides = pkgs: {
    icalBuddy = pkgs.callPackage ./icalBuddy/package.nix {};
  };
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (_: pyprev: {
            afdko = pyprev.afdko.overridePythonAttrs (_: {doCheck = false;});
          })
        ];
    })
  ];
}
