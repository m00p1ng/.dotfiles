{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  home.homeDirectory = "<path/to/home>";
  home.username = "<username>";

  programs.git = {
    userName = "<git username>";
    userEmail = "<git email>";
  };
}
