{
  programs.zed-editor = {
    userSettings = {
      agent_servers = {
        gemini = {
          type = "registry";
        };
        "github-copilot-cli" = {
          type = "registry";
        };
      };
      base_keymap = "VSCode";
      preview_tabs = {
        enabled = true;
      };
      sticky_scroll = {
        enabled = false;
      };
      minimap = {
        show = "never";
      };
      file_types = {
        dotenv = [".env*"];
        dockerfile = ["[Dd]ockerfile*"];
        yaml = ["docker-compose*"];
      };
      wrap_guides = [80 100 120];
      hard_tabs = false;
      tab_size = 2;
      vim_mode = true;
      icon_theme = "Icons modern material (Dark)";
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = {
        mode = "dark";
        light = "Ayu Light";
        dark = "Catppuccin Mocha";
      };
      # lsp = {
      #   wakatime = {
      #     initialization_options = {
      #       "api-key" = "Your api key";
      #     };
      #   };
      # };
    };
    extensions = [
      "catppuccin"
      "icons-modern-material"
      "wakatime"
    ];
  };
}
