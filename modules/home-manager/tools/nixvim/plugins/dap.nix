{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      delve
    ];

    plugins = {
      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap-go = {
        enable = true;
        settings = {
          delve = {
            path = "${pkgs.delve}/bin/dlv";
          };
        };
      };
    };

    keymaps = [
      { mode = "n"; key = "<Leader>db"; action = "<cmd>DapToggleBreakpoint<CR>"; options.desc = "Toggle breakpoint"; }
      { mode = "n"; key = "<Leader>dc"; action = "<cmd>DapContinue<CR>"; options.desc = "Continue"; }
      { mode = "n"; key = "<Leader>di"; action = "<cmd>DapStepInto<CR>"; options.desc = "Step into"; }
      { mode = "n"; key = "<Leader>do"; action = "<cmd>DapStepOver<CR>"; options.desc = "Step over"; }
      { mode = "n"; key = "<Leader>dO"; action = "<cmd>DapStepOut<CR>"; options.desc = "Step out"; }
      { mode = "n"; key = "<Leader>dr"; action = "<cmd>DapToggleRepl<CR>"; options.desc = "Toggle REPL"; }
      { mode = "n"; key = "<Leader>dt"; action = "<cmd>DapTerminate<CR>"; options.desc = "Terminate"; }
      { mode = "n"; key = "<Leader>du"; action.__raw = "function() require('dapui').toggle() end"; options.desc = "Toggle DAP UI"; }
      { mode = "n"; key = "<Leader>dgt"; action.__raw = "function() require('dap-go').debug_test() end"; options.desc = "Debug Go test"; }
      { mode = "n"; key = "<Leader>dgl"; action.__raw = "function() require('dap-go').debug_last_test() end"; options.desc = "Debug last Go test"; }
    ];

    extraConfigLua = ''
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    '';
  };
}
