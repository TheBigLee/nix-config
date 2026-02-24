return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    search = {
      pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
    },
    highlight = {
      pattern = [[.*<((KEYWORDS)%(.{-1,})?):]],
    },
  },
}
