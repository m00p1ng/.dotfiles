{
  lib,
  pkgs,
  ...
}:
with lib; let
  jsonFormat = pkgs.formats.json {};
in {
  options.my-config = {
    ghostty = {
      enable = mkEnableOption "Ghostty terminal config";
    };
    zed = {
      enable = mkEnableOption "Zed editor configuration";
      settings = mkOption {
        inherit (jsonFormat) type;
        default = {};
      };
    };
  };
}
