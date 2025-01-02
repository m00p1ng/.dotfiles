{pkgs, ...}: {
  home.packages = with pkgs; [
    coreutils
    gnused
    gawk
  ];
}
