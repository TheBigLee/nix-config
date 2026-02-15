return {
  'nvim-mini/mini.base16',
  version = '*',
  config = function()
    require('mini.base16').setup({
      palette = {
        base00 = '#191c1e', base01 = '#434841', base02 = '#656d66', base03 = '#8da1a8',
        base04 = '#bfb9a2', base05 = '#dfe4dd', base06 = '#f9f1d3', base07 = '#fbf0d3',
        base08 = '#b18876', base09 = '#969085', base0A = '#a28c84', base0B = '#93927c',
        base0C = '#81958f', base0D = '#a48e6a', base0E = '#8d928d', base0F = '#7e949f'
      }
    })

    local function make_transparent()
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    make_transparent()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = make_transparent,
    })

    -- Defer to ensure it runs after all plugins finish loading
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(make_transparent)
      end,
    })
  end,
}
