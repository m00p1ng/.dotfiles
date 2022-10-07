{ config, ... }:

{
  programs.kitty = {
    enable = true;
  };

  xdg.configFile.kitty = {
    source = ../configs/kitty;
    recursive = true;
  };

  programs.fish = {
    shellAliases = {
      ssh = "kitty +kitten ssh";
    };
  };
}
