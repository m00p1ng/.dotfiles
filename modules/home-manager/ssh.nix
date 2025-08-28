{
  programs.ssh = {
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        setEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
