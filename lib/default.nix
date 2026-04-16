{lib, ...}: {
  mkMutableConfig = {
    src ? null,
    text ? null,
    dest,
  }:
    assert lib.asserts.assertMsg
      (src != null || text != null)
      "mkMutableConfig: `src` or `content` must be provided";
    assert lib.asserts.assertMsg
      (src == null || text == null)
      "mkMutableConfig: `src` and `content` are mutually exclusive";
      if src != null
      then /* sh */ ''
        if [ -f "${src}" ]; then
          mkdir -p "$(dirname "${dest}")"
          cp -f "${src}" "${dest}"
          chmod u+w "${dest}"
        elif [ -d "${src}" ]; then
          mkdir -p "${dest}"
          cp -rf "${src}/." "${dest}"
          chmod -R u+w "${dest}"
        fi
      ''
      else /* sh */ ''
        mkdir -p "$(dirname "${dest}")"
        printf '%s' '${text}' > "${dest}"
        chmod u+w "${dest}"
      '';

  scanPaths = path:
    builtins.map
    (f: path + "/${f}")
    (builtins.attrNames
      (lib.filterAttrs
        (name: type:
          (type != "directory" && name != "default.nix") # ignore default.nix
          && lib.hasSuffix ".nix" name) # include .nix files
        
        (builtins.readDir path)));
}
