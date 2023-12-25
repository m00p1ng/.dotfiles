{ pkgs, lib, username, ... }:

with lib;
{
  nix = {
    package = pkgs.nix;

    # Enable experimental nix command and flakes
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '' + optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  users.users.${username} = {
    home =
      if pkgs.stdenvNoCC.isDarwin
      then "/Users/${username}"
      else "/home/${username}";
  };
}
