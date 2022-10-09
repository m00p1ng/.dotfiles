{ pkgs, ... }:

{
  home.packages = with pkgs; [
    onefetch
  ];

  programs.git = {
    aliases = {
      info = "!onefetch";
    };
  };
}
