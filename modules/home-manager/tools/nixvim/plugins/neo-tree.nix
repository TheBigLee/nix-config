{ ... }:
{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      settings = {
        enable_diagnostics = true;
        enable_git_status = true;
        enable_modified_markers = true;
        enable_refresh_on_write = true;
        close_if_last_window = false;
        popup_border_style = "rounded";
        buffers = {
          bind_to_cwd = false;
          follow_current_file.enabled = true;
        };
        window = {
          width = 40;
          height = 15;
          auto_expand_width = false;
          mappings = {
            "<space>" = "none";
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Leader>e";
        action = "<cmd>Neotree toggle reveal_force_cwd<CR>";
        options.desc = "Explorer (root dir)";
      }
      {
        mode = "n";
        key = "<Leader>E";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Explorer (cwd)";
      }
      {
        mode = "n";
        key = "<Leader>be";
        action = "<cmd>Neotree buffers<CR>";
        options.desc = "Buffer explorer";
      }
      {
        mode = "n";
        key = "<Leader>ge";
        action = "<cmd>Neotree git_status<CR>";
        options.desc = "Git explorer";
      }
    ];
  };
}
