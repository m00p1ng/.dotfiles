{ pkgs, ... }:

let
  pythonEnv = pkgs.python3Full.withPackages (ps: [
    ps.ipython
    ps.pip
    # ps.numpy
    # ps.pandas
    # ps.debugpy
    ps.pytest
  ]);
in
{
  home.packages = [
    pythonEnv
  ];
}
