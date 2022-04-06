{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "my-user-name";
  home.homeDirectory = "/my/home/path";
  programs.git.userName = "my-git-username";
  programs.git.userEmail = "my-git-email";

  xdg.enable = true;
  xdg.configHome = "~/.config";
  xdg.dataHome = "~/.local/share";
  xdg.cacheHome = "~/.cache";
}
