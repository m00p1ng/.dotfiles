{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ruby
    pry
  ];
}
