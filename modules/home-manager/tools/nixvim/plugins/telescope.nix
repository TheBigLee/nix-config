{ ... }:
{
  programs.nixvim = {
    plugins.web-devicons.enable = true;
    plugins.telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
      extensions.file-browser = {
        enable = true;
        settings = {
          hijack_netrw = false;
          grouped = true;
          sorting_strategy = "ascending";
          initial_mode = "normal";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<Leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<Leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<Leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<Leader>fe";
        action = "<cmd>Telescope file_browser<CR>";
        options.desc = "File browser";
      }
      {
        mode = "n";
        key = "<Leader>ft";
        action = "<cmd>Telescope treesitter<CR>";
        options.desc = "Treesitter symbols";
      }
      {
        mode = "n";
        key = "<Leader>fs";
        action = "<cmd>Telescope spell_suggest<CR>";
        options.desc = "Spell suggestions";
      }
    ];
  };
}
