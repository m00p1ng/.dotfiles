{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    imagemagick
    ghostscript_headless
    tectonic
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
