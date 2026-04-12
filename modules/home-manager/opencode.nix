{config, ...}: let
  lspRoot = "${config.xdg.dataHome}/nvim/mason/bin";
in {
  programs.opencode = {
    settings = {
      lsp = {
        typescript = {
          command = ["${lspRoot}/vtsls" "--stdio"];
        };
        pyright = {
          command = ["${lspRoot}/basedpyright-langserver" "--stdio"];
        };
      };
    };
  };
}
