
{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
