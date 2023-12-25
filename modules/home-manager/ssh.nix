{
  programs.ssh = {
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_rsa";
      };
    };
  };
}
