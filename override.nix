{
  pkgs,
  lib,
  username,
  ...
}:
with lib; {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      ffmpeg
      nmap
    ];

    programs.git = {
      settings = {
        user = {
          name = "m00p1ng";
          email = "mongkonchai4412@gmail.com";
        };
      };
    };
  };

  homebrew = {
    casks = [];
  };
}
