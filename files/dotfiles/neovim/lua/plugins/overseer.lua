return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerToggle", "OverseerRun", "OverseerRunCmd", "OverseerBuild" },
  keys = {
    { "<Leader>ot", "<cmd>OverseerToggle<CR>", desc = "Toggle task list" },
    { "<Leader>or", "<cmd>OverseerRun<CR>", desc = "Run task" },
    { "<Leader>oc", "<cmd>OverseerRunCmd<CR>", desc = "Run shell command" },
    { "<Leader>ob", "<cmd>OverseerBuild<CR>", desc = "Build task" },
    { "<Leader>oq", "<cmd>OverseerQuickAction<CR>", desc = "Quick action (recent task)" },
    { "<Leader>oa", "<cmd>OverseerTaskAction<CR>", desc = "Task action" },
  },
  opts = {},
}

