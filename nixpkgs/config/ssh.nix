{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/id_rsa
    '';
  };

  home.packages = with pkgs; [
    openssh
  ];
}
