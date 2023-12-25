{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fnm
  ];

  programs.fish = {
    interactiveShellInit = ''
      # FNM configuration
      fnm env --use-on-cd | source
      fnm completions --shell fish | source
    '';
  };
}
