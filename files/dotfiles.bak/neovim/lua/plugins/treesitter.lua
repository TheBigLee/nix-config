return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    opts = {
      ensure_installed = {},
      auto_install = false,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      max_lines = 3,
    },
  },
}
