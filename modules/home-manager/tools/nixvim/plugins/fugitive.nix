{ ... }:
{
  programs.nixvim = {
    plugins.fugitive.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<Leader>gs";
        action = "<cmd>G<CR>";
        options.desc = "Git status";
      }
      {
        mode = "n";
        key = "<Leader>gj";
        action = "<cmd>diffget //3<CR>";
        options.desc = "Diffget from right (upstream)";
      }
      {
        mode = "n";
        key = "<Leader>gf";
        action = "<cmd>diffget //2<CR>";
        options.desc = "Diffget from left (head)";
      }
    ];
  };
}
