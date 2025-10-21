{
  pkgs,
  lib,
  username,
  ...
}:
with lib; {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
    ];

    programs.git = {
      settings = {
        user = {
          name = "<git username>";
          email = "<git email>";
        };
      };
    };
  };
}
