{ pkgs, ... }:

{
  home.packages = with pkgs; [
    less
  ];

  home.sessionVariables = {
    "LESS" = "--mouse";
  };
}
