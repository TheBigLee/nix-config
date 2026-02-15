return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
    },
    extensions = { "neo-tree", "nvim-dap-ui", "overseer", "toggleterm" },
  },
}
