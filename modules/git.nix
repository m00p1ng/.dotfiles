{
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    aliases = {
      logs = "log --abbrev-commit --graph --decorate --oneline";
      logl = "log --oneline -10";
      logs-full = "log --graph --pretty='%C(yellow)%h%C(reset) -%C(auto)%d%C(reset) %s %C(green)(%cr) %C(dim white)<%an>%C(reset)'";
      logs-date = "log --graph --pretty='%C(yellow)%h%C(reset) -%C(auto)%d%C(reset) %s %C(green)(%cr)%C(reset)'";
      logs-author = "log --graph --pretty='%C(yellow)%h%C(reset) -%C(auto)%d%C(reset) %s %C(green)%an%C(reset)'";
      follow = "!git --no-pager log --follow --oneline";
      count = "shortlog -ns";
      find = "log --all --full-history --oneline";
      parent = "!git show-branch | grep '*' | grep -v \"$(git rev-parse --abbrev-ref HEAD)\" | head -n1 | sed 's/.*\\[\\(.*\\)\\].*/\\1/' | sed 's/[\\^~].*//' #";
      diffs = "!git -c delta.side-by-side=true diff";
    };
    extraConfig = {
      core = {
        editor = "nvim";
        ignorecase = false;
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        tool = "vimdiff";
      };
      pager = {
        branch = false;
        shortlog = false;
      };
      color = {
        ui = true;
        status = {
          added = "green bold";
          changed = "yellow bold";
          untracked = "red bold";
        };
        diff = {
          meta = "11";
          frag = "magenta bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
      };
      diff = {
        colorMoved = "default";
      };
      pull = {
        rebase = false;
      };
    };
    delta = {
      enable = true;
      options = {
        features = "line-numbers file-decorators";
        inspect-raw-lines = false;
        syntax-theme = "Visual Studio Dark+";
        line-numbers = {
          line-numbers-zero-style = "243";
          line-numbers-left-style = "243";
          line-numbers-right-style = "243";
          line-numbers-minus-style = "red";
          line-numbers-plus-style = "green";
        };
        file-decorators = {
          file-style = "bold yellow";
          file-modified-label = "modified:";
          file-decoration-style = "yellow box ul";
          hunk-header-style = "syntax";
          hunk-header-decoration-style = "243 box";
          commit-decoration-style = "green box ul";
        };
      };
    };
  };
}
