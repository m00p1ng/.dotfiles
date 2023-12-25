{ pkgs, ... }:

let
  pythonEnv = pkgs.python311.withPackages (ps: [
    ps.ipython
    ps.pip
    ps.pynvim
  ]);
in
{
  home.packages = [
    pythonEnv
  ];
}
