return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {},
  config = function(_, opts)
    require("notify").setup({ background_colour = "#000000" })
    require("noice").setup(opts)
  end,
}
