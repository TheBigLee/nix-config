return {
  "fresh2dev/zellij.vim",
  lazy = false,
  init = function()
    vim.g.zellij_navigator_no_default_mappings = 1
  end,
  config = function()
    vim.keymap.set("n", "<A-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "Zellij navigate left" })
    vim.keymap.set("n", "<A-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "Zellij navigate down" })
    vim.keymap.set("n", "<A-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "Zellij navigate up" })
    vim.keymap.set("n", "<A-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "Zellij navigate right" })
  end,
}
