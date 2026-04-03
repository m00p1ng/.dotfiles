{config, ...}: {
  programs.go = {
    env = {
      GOPATH = "${config.home.homeDirectory}/tools/go";
    };
  };
}
