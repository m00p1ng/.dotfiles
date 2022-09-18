{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fnm
  ];

  xdg.configFile."fish/conf.d/fnm.fish".text = ''
    fnm env --use-on-cd | source
    fnm completions --shell fish | source
  '';
}
