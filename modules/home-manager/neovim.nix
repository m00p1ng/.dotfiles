{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    imagemagick
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
