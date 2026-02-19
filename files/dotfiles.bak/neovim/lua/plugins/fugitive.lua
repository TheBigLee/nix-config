return {
  "tpope/vim-fugitive",
  cmd = "G",
  keys = {
    { "<Leader>gs", "<cmd>G<CR>", desc = "Git status" },
    { "<Leader>gj", "<cmd>diffget //3<CR>", desc = "Diffget from right (upstream)" },
    { "<Leader>gf", "<cmd>diffget //2<CR>", desc = "Diffget from left (head)" },
  },
}
