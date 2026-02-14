{ ... }:
{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    settings = {
      search.pattern = "\\b(KEYWORDS)(\\([^\\)]*\\))?:";
      highlight.pattern = ".*<((KEYWORDS)%(.{-1,})?):";
    };
  };
}
