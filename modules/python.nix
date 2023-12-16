{ pkgs, ... }:

let
  pythonEnv = pkgs.python311.withPackages (ps: [
    ps.ipython
    ps.pip
    ps.pynvim
    # ps.numpy
    # ps.pandas
    # ps.debugpy
    # ps.black
    # ps.pytest
  ]);
in
{
  home.packages = [
    pythonEnv
  ];
}
