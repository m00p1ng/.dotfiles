{ pkgs, ... }:

let
  pythonEnv = pkgs.python3Full.withPackages (ps: [
    ps.ipython
    ps.pip
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
