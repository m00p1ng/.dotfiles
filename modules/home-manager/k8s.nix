{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    kubectl
    k9s
    stern
  ];

  home.sessionVariables = {
    K9SCONFIG = "${config.xdg.configHome}/k9s";
  };

  xdg.configFile.k9s = {
    source = ./configs/k9s;
    recursive = true;
  };

  xdg.configFile.stern = {
    source = ./configs/stern;
    recursive = true;
  };

  programs.fish = {
    shellAliases = {
      k = "kubectl";
    };
  };
}