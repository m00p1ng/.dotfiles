{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_rsa

      Host *
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_rsa
    '';
  };

  home.packages = with pkgs; [
    openssh
  ];
}
