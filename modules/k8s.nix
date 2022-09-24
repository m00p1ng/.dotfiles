{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    helmfile
    k9s
    minikube
    stern
  ];

  home.sessionVariables = {
    "K9SCONFIG" = "${config.xdg.configHome}/k9s";
  };

  xdg.configFile.k9s = {
    source = ../configs/k9s;
    recursive = true;
  };
}
