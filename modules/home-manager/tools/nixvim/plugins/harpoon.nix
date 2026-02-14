{ ... }:
{
  programs.nixvim = {
    plugins.harpoon = {
      enable = true;
      enableTelescope = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<Leader>a";
        action.__raw = "function() require('harpoon'):list():add() end";
        options.desc = "Harpoon add file";
      }
      {
        mode = "n";
        key = "<C-e>";
        action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
        options.desc = "Harpoon menu";
      }
      {
        mode = "n";
        key = "<C-h>";
        action.__raw = "function() require('harpoon'):list():select(1) end";
        options.desc = "Harpoon file 1";
      }
      {
        mode = "n";
        key = "<C-j>";
        action.__raw = "function() require('harpoon'):list():select(2) end";
        options.desc = "Harpoon file 2";
      }
      {
        mode = "n";
        key = "<C-k>";
        action.__raw = "function() require('harpoon'):list():select(3) end";
        options.desc = "Harpoon file 3";
      }
      {
        mode = "n";
        key = "<C-l>";
        action.__raw = "function() require('harpoon'):list():select(4) end";
        options.desc = "Harpoon file 4";
      }
      {
        mode = "n";
        key = "<C-p>";
        action.__raw = "function() require('harpoon'):list():prev() end";
        options.desc = "Harpoon previous";
      }
      {
        mode = "n";
        key = "<C-n>";
        action.__raw = "function() require('harpoon'):list():next() end";
        options.desc = "Harpoon next";
      }
    ];
  };
}
