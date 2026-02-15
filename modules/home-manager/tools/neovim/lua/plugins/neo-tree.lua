return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<Leader>e", "<cmd>Neotree toggle reveal_force_cwd<CR>", desc = "Explorer (root dir)" },
    { "<Leader>E", "<cmd>Neotree toggle<CR>", desc = "Explorer (cwd)" },
    { "<Leader>be", "<cmd>Neotree buffers<CR>", desc = "Buffer explorer" },
    { "<Leader>ge", "<cmd>Neotree git_status<CR>", desc = "Git explorer" },
  },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
      desc = "Start Neo-tree with directory",
      once = true,
      callback = function()
        if package.loaded["neo-tree"] then
          return
        end
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == "directory" then
          require("neo-tree")
        end
      end,
    })
  end,
  opts = {
    enable_diagnostics = true,
    enable_git_status = true,
    enable_modified_markers = true,
    enable_refresh_on_write = true,
    close_if_last_window = false,
    popup_border_style = "rounded",
    buffers = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
    },
    filesystem = {
      hijack_netrw_behavior = "open_default",
      follow_current_file = { enabled = true },
    },
    window = {
      width = 40,
      height = 15,
      auto_expand_width = false,
      mappings = {
        ["<space>"] = "none",
      },
    },
  },
}
