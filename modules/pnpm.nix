{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    nodePackages.pnpm
  ];

  home.sessionVariables = {
    PNPM_HOME = "${config.home.homeDirectory}/tools/pnpm";
  };

  xdg.configFile."fish/conf.d/pnpm.fish".text = ''
    fish_add_path ${config.home.homeDirectory}/tools/pnpm
  '';

  programs.fish = {
    shellAbbrs = {
      pn = "pnpm";
    };
  };
}
