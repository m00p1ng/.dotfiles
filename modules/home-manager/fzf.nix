{
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--reverse"
      "--inline-info"
    ];

    historyWidgetOptions = [
      "--height=12"
    ];
  };
}
