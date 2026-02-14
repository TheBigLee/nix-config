{ ... }:
{
  programs.nixvim = {
    plugins.undotree.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<Leader>u";
        action = "<cmd>UndotreeToggle<CR>";
        options.desc = "Toggle undotree";
      }
    ];
  };
}
