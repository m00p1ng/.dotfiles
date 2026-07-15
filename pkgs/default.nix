{
  nixpkgs.config.packageOverrides = pkgs: {
    icalBuddy = pkgs.callPackage ./icalBuddy/package.nix {};
    # cctools-1010.6 ld crashes (BPT trap) on macOS 26 — use prebuilt for yabai, custom build for sketchybar
    yabai = pkgs.yabai.overrideAttrs (_: {
      src = pkgs.fetchurl {
        url = "https://github.com/koekeishiya/yabai/releases/download/v7.1.25/yabai-v7.1.25.tar.gz";
        sha256 = "sha256-dvODhBVwv+Hj/STO3ZsaS4BLQ7DznIapUcl9GH/GsbQ=";
      };
      dontBuild = true;
      dontPatch = true;
      dontConfigure = true;
      dontFixup = true;
      installPhase = ''
        runHook preInstall
        install -Dm755 bin/yabai $out/bin/yabai
        runHook postInstall
      '';
    });
    sketchybar = pkgs.callPackage ./sketchybar/package.nix {};
  };
}
