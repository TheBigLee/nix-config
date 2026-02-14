{ ... }:
{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      settings.options = {
        separator_style = "slant";
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
        ];
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Tab>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<Leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<Leader>bo";
        action = "<cmd>BufferLineCloseOthers<CR>";
        options.desc = "Close other buffers";
      }
      {
        mode = "n";
        key = "<Leader>bp";
        action = "<cmd>BufferLineTogglePin<CR>";
        options.desc = "Toggle pin";
      }
    ];
  };
}
