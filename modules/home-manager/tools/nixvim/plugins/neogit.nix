{ ... }:
{
  programs.nixvim = {
    plugins.neogit.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<Leader>gn";
        action = "<cmd>Neogit<CR>";
        options.desc = "Neogit";
      }
    ];
  };
}
