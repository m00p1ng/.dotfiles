{pkgs, ...}: let
  catppuccinBat = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "699f60fc8ec434574ca7451b444b880430319941";
    sha256 = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
  };
in {
  programs.bat = {
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  xdg.configFile."bat/themes" = {
    source = "${catppuccinBat}/themes";
    recursive = true;
  };
}
