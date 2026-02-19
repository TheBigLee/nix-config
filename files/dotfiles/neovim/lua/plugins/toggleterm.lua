return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<Leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    { "<Esc>",      "<C-\\><C-n>",         mode = "t",              desc = "Exit terminal mode" },
  },
  opts = {
    direction = "float",
    float_opts = {
      border = "curved",
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })

    vim.keymap.set("n", "<Leader>gg", function()
      lazygit:toggle()
    end, { noremap = true, silent = true, desc = "Lazygit" })
  end,
}
