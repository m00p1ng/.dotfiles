{
  lib,
  pkgs,
  ...
}: {
  /**
  * mkMutableConfig
  *
  * Copies a file or directory from `src` or writes `text` to a destination `dest`,
  * making the destination mutable (writable by the user).
  *
  * - If `src` is a file, it copies the file to `dest`, backing up any existing file as `dest.bak`.
  * - If `src` is a directory, it copies the directory contents to `dest`, backing up any existing directory as `dest.bak`.
  * - If `text` is provided (and `src` is null), it writes the text to `dest`, backing up any existing file as `dest.bak`.
  * - `src` and `text` are mutually exclusive; one must be provided.
  *
  * Arguments:
  *   src  (optional): Path to source file or directory to copy.
  *   text (optional): Text content to write to dest if src is not provided.
  *   dest (required): Destination path for the file or directory.
  *
  * Returns:
  *   Shell script string that performs the copy or write operation and ensures dest is writable.
  */
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

  /**
  * mkJSONMutableConfig
  *
  * Serializes a Nix value to JSON and writes it to a destination `dest`,
  * making the destination mutable (writable by the user).
  *
  * - If `dest` already exists, the new JSON is recursively merged over the existing file using `jq`.
  *
  * Arguments:
  *   value (required): Nix value to serialize as JSON.
  *   dest  (required): Destination path for the JSON file.
  *
  * Returns:
  *   Shell script string that performs the write operation and ensures dest is writable.
  */
  mkJSONMutableConfig = {
    value,
    dest,
  }: let
    escapedDest = lib.escapeShellArg dest;
    resolvedText = builtins.toJSON value;
  in
    #sh
    ''
      mkdir -p "$(dirname ${escapedDest})"
      [ -f ${escapedDest} ] && cp -f ${escapedDest} ${escapedDest}.bak
      if [ -f ${escapedDest}.bak ]; then
        ${lib.getExe pkgs.jq} -s '.[0] * .[1]' ${escapedDest}.bak - <<'__JSON__' | ${lib.getExe pkgs.jq} '.' > ${escapedDest}
      ${resolvedText}
      __JSON__
      else
        printf '%s' '${resolvedText}' | ${lib.getExe pkgs.jq} '.' > ${escapedDest}
      fi
      chmod u+w ${escapedDest}
    '';

  /**
  * scanPaths
  *
  * Returns a list of all `.nix` files in `path` (non-recursive), excluding `default.nix`.
  *
  * Arguments:
  *   path (required): Directory path to scan.
  *
  * Returns:
  *   List of absolute paths to `.nix` files in the directory.
  */
  scanPaths = path:
    lib.pipe (builtins.readDir path) [
      (lib.filterAttrs (name: type:
        (type != "directory" && name != "default.nix") # ignore default.nix
        && lib.hasSuffix ".nix" name)) # include .nix files
      builtins.attrNames
      (map (f: path + "/${f}"))
    ];

  /**
  * scanPathsRecursive
  *
  * Returns a flat list of all `.nix` files under `path` (recursive), excluding any `default.nix`.
  *
  * Arguments:
  *   path (required): Root directory path to scan recursively.
  *
  * Returns:
  *   Flat list of absolute paths to all `.nix` files found under the directory tree.
  */
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
