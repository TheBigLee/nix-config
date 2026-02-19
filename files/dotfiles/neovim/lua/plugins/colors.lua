return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        disable_float_background = true,
        styles = {
          italic = false,
        },
        highlight_groups = {
          WhichKeyNormal = { bg = "#1a1a1a" };
        },
      })
      vim.cmd.colorscheme('rose-pine-moon') 
    end
  },
}
