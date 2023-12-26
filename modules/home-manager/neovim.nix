{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.fish = {
    shellAliases = {
      vim = "nvim";
    };
  };
}
