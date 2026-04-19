{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    # tree-sitter

    imagemagick
    ghostscript_headless
    tectonic
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.tmux.interactivePrograms = ["nvim"];
}
