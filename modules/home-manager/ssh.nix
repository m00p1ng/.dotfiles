{
  programs.ssh = {
    addKeysToAgent = "yes";
  };

  programs.fish = {
    shellAliases = {
      ssh = "TERM=xterm-256color command ssh";
    };
  };
}
