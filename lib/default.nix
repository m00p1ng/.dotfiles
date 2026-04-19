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
      then #sh
        ''
          if [ -f ${escapedSrc} ]; then
            mkdir -p "$(dirname ${escapedDest})"
            [ -f ${escapedDest} ] && cp -f ${escapedDest} ${escapedDest}.bak
            cp -f ${escapedSrc} ${escapedDest}
            chmod u+w ${escapedDest}
          elif [ -d ${escapedSrc} ]; then
            mkdir -p ${escapedDest}
            [ -d ${escapedDest} ] && cp -rf ${escapedDest}/. ${escapedDest}.bak
            cp -rf ${escapedSrc}/. ${escapedDest}
            chmod -R u+w ${escapedDest}
          fi
        ''
      else #sh
        ''
          mkdir -p "$(dirname ${escapedDest})"
          [ -f ${escapedDest} ] && cp -f ${escapedDest} ${escapedDest}.bak
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

  scanPathsRecursive = path: let
    go = p:
      lib.pipe (builtins.readDir p) [
        (lib.filterAttrs (name: _: name != "default.nix"))
        (lib.mapAttrsToList (name: type:
          if type == "directory"
          then go (p + "/${name}")
          else if lib.hasSuffix ".nix" name
          then [(p + "/${name}")]
          else []))
        lib.flatten
      ];
  in
    go path;
}
