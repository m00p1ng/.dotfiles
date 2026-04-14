let
  # lspRoot = "${config.xdg.dataHome}/nvim/mason/bin";
in {
  programs.opencode = {
    settings = {
      lsp = {
        typescript = {
          disabled = true;
        };
        vtsls = {
          command = ["vtsls" "--stdio"];
          extensions = [".ts" ".tsx" ".js" ".jsx" ".mjs" ".cjs" ".mts" ".cts"];
        };
        pyright = {
          disabled = true;
        };
        basedpyright-langserver = {
          command = ["basedpyright-langserver" "--stdio"];
          extensions = [".py" ".pyi"];
        };
      };
    };
  };
}
