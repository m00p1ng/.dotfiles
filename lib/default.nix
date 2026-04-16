{lib, ...}: {
  mkMutableConfig = {
    src ? null,
    text ? null,
    dest,
  }:
    assert lib.asserts.assertMsg (src != null || text != null) "mkMutableConfig: `src` or `text` must be provided";
    assert lib.asserts.assertMsg (src == null || text == null) "mkMutableConfig: `src` and `text` are mutually exclusive"; let
      escapedSrc = lib.escapeShellArg src;
      escapedDest = lib.escapeShellArg dest;
    in
      if src != null
      then /* sh */ ''
        if [ -f ${escapedSrc} ]; then
          mkdir -p "$(dirname ${escapedDest})"
          cp -f ${escapedSrc} ${escapedDest}
          chmod u+w ${escapedDest}
        elif [ -d ${escapedSrc} ]; then
          mkdir -p ${escapedDest}
          cp -rf ${escapedSrc}/. ${escapedDest}
          chmod -R u+w ${escapedDest}
        fi
      ''
      else /* sh */ ''
        mkdir -p "$(dirname ${escapedDest})"
        printf '%s' '${text}' > ${escapedDest}
        chmod u+w ${escapedDest}
      '';

  scanPaths = path:
    lib.pipe (builtins.readDir path) [
      (lib.filterAttrs (name: type:
        (type != "directory" && name != "default.nix") # ignore default.nix
        && lib.hasSuffix ".nix" name)) # include .nix files
      builtins.attrNames
      (map (f: path + "/${f}"))
    ];
}
