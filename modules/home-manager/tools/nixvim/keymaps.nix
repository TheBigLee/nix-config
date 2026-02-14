{ ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      # Clear search highlighting
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }

      # Better window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move to left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move to lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move to upper window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move to right window";
      }

      # Better indenting (stay in visual mode)
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }

      # Move selected lines
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move selection down";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move selection up";
      }

      # Centered scrolling
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options.desc = "Scroll down (centered)";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options.desc = "Scroll up (centered)";
      }

      # Centered search navigation
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options.desc = "Next search result (centered)";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options.desc = "Previous search result (centered)";
      }

      # Paste without overriding register
      {
        mode = "v";
        key = "<Leader>p";
        action = "\"_dP";
        options.desc = "Paste without overriding register";
      }

      # Yank to system clipboard
      {
        mode = [ "n" "v" ];
        key = "<Leader>y";
        action = "\"+y";
        options.desc = "Yank to system clipboard";
      }
    ];
  };
}
