{ pkgs, lib, username, ... }:

with lib;
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
    ];

    programs.git = {
      userName = "<git username>";
      userEmail = "<git email>";
    };
  };
}
