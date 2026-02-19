return {
  'nvim-telescope/telescope.nvim', version = 'v0.2.1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  cmd = "Telescope",
  keys = {
    { "<Leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<Leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<Leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<Leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<Leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
    { "<Leader>ft", "<cmd>Telescope treesitter<CR>", desc = "Treesitter symbols" },
    { "<Leader>fs", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggestions" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        file_browser = {
          hijack_netrw = false,
          grouped = true,
          sorting_strategy = "ascending",
          initial_mode = "insert",
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
  end,
}
