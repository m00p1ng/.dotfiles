{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fnm
  ];

  xdg.configFile."fish/conf.d/fnm.fish".text = ''
    fnm env --use-on-cd | source
  '';

  xdg.configFile."fish/completions/fnm.fish".text = ''
    fnm completions --shell fish | source
  '';
}
