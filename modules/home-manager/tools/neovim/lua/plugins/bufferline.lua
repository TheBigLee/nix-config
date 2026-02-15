return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      separator_style = "slant",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "<Leader>bd", "<cmd>bdelete<CR>", desc = "Delete buffer" },
    { "<Leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
    { "<Leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
  },
}
