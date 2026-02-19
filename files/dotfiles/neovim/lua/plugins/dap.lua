return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      config = function()
        require("dapui").setup()
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "leoluz/nvim-dap-go",
      opts = {
        delve = {
          path = "dlv",
        },
      },
    },
  },
  keys = {
    { "<Leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
    { "<Leader>dc", "<cmd>DapContinue<CR>",         desc = "Continue" },
    { "<Leader>di", "<cmd>DapStepInto<CR>",         desc = "Step into" },
    { "<Leader>do", "<cmd>DapStepOver<CR>",         desc = "Step over" },
    { "<Leader>dO", "<cmd>DapStepOut<CR>",          desc = "Step out" },
    { "<Leader>dr", "<cmd>DapToggleRepl<CR>",       desc = "Toggle REPL" },
    { "<Leader>dt", "<cmd>DapTerminate<CR>",        desc = "Terminate" },
    {
      "<Leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle DAP UI",
    },
    {
      "<Leader>dgt",
      function()
        require("dap-go").debug_test()
      end,
      desc = "Debug Go test",
    },
    {
      "<Leader>dgl",
      function()
        require("dap-go").debug_last_test()
      end,
      desc = "Debug last Go test",
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    local function set_debug_keymaps()
      vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Continue" })
      vim.keymap.set("n", "<F9>", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "Step over" })
      vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>", { desc = "Step into" })
      vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<CR>", { desc = "Step out" })
      vim.keymap.set("n", "<S-F5>", "<cmd>DapTerminate<CR>", { desc = "Terminate" })
    end

    local function unset_debug_keymaps()
      pcall(vim.keymap.del, "n", "<F5>")
      pcall(vim.keymap.del, "n", "<F9>")
      pcall(vim.keymap.del, "n", "<F10>")
      pcall(vim.keymap.del, "n", "<F11>")
      pcall(vim.keymap.del, "n", "<F12>")
      pcall(vim.keymap.del, "n", "<S-F5>")
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
      set_debug_keymaps()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
      set_debug_keymaps()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
      unset_debug_keymaps()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
      unset_debug_keymaps()
    end
  end,
}
