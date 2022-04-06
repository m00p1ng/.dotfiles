{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_rsa";
      };
    };
  };

  home.packages = with pkgs; [
    openssh
  ];
}
