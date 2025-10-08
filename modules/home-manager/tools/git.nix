{ inputs, ... }:

{
  programs.git = {
    enable = true;
    userName = inputs.nix-secrets.name;
    userEmail = inputs.nix-secrets.email.work;
    aliases = {
      ci = "commit -s";
      co = "checkout";
      st = "status";
      s = "status -s";
      ol = "log --oneline --graph";
      lg = "log --oneline --decorate --all --graph";
      hist = "log --graph --full-history --all --color --pretty=format:'%x1b[33m%h%x09%C(blue)(%ar)%C(reset)%x09%x1b[32m%d%x1b[0m%x20%s%x20%C(dim white)-%x20%an%C(reset)'";
      dc = "diff --check";
      tag-dates = "log --tags --simplify-by-decoration --pretty=\"format:%ai %d\"";
      log-sig = "log --pretty=\"format:%h %G? %aN %s\"";
      unstage = "reset HEAD";
      staged = "diff --staged";
      yolopush = "push --force-with-lease";
      fix = "commit --fixup";
      squ = "commit --squash";
      ri = "rebase -i --autosquash";
      pp = "pull --prune";
      brnach = "branch";
    };
    difftastic = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      merge.conflictStyle = "zdiff3";
      pull = {
        ff = "only";
        rebase = true;
      };
      push.autoSetupRemote = "true";
      submodule.recurse = true;
      commit = {
        gpgsign = true;
        verbose = true;
      };
    };
  };
}
