{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--type-add=web:*.{html,css,scss,sass,vue,js,jsx,ts,tsx}*"

      "--colors=line:fg:yellow"
      "--colors=line:style:bold"

      "--colors=path:fg:green"
      "--colors=path:style:bold"

      "--glob=!.git/"
      "--hidden"
    ];
  };
}
