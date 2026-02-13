# Debug Adapter Protocol (DAP) plugins
{ config, lib, pkgs, ... }:
{
  options = {
    nixvim-config.plugins.dap.enable = lib.mkEnableOption "enables DAP debugging module";
  };

  config = lib.mkIf config.nixvim-config.plugins.dap.enable {
    programs.nixvim = {
      # Add delve for Go debugging
      extraPackages = with pkgs; [
        delve
      ];

      plugins = {
        # Core DAP plugin (required dependency)
        dap = {
          enable = true;
        };

        # DAP UI - rcarriga/nvim-dap-ui
        dap-ui = {
          enable = true;
        };

        # DAP virtual text - theHamsta/nvim-dap-virtual-text
        dap-virtual-text = {
          enable = true;
        };

        # Go DAP configuration
        dap-go = {
          enable = true;
          settings = {
            delve = {
              path = "${pkgs.delve}/bin/dlv";
            };
          };
        };
      };

      # vim-go - fatih/vim-go (not a nixvim module, add via extraPlugins)
      extraPlugins = [ pkgs.vimPlugins.vim-go ];

      # DAP keymaps
      keymaps = [
        { key = "<leader>db"; action = "<cmd>DapToggleBreakpoint<cr>"; options.desc = "Toggle breakpoint"; }
        { key = "<leader>dc"; action = "<cmd>DapContinue<cr>"; options.desc = "Continue"; }
        { key = "<leader>di"; action = "<cmd>DapStepInto<cr>"; options.desc = "Step into"; }
        { key = "<leader>do"; action = "<cmd>DapStepOver<cr>"; options.desc = "Step over"; }
        { key = "<leader>dO"; action = "<cmd>DapStepOut<cr>"; options.desc = "Step out"; }
        { key = "<leader>dr"; action = "<cmd>DapToggleRepl<cr>"; options.desc = "Toggle REPL"; }
        { key = "<leader>dt"; action = "<cmd>DapTerminate<cr>"; options.desc = "Terminate"; }
        { key = "<leader>du"; action.__raw = "function() require('dapui').toggle() end"; options.desc = "Toggle DAP UI"; }
        { key = "<leader>dgt"; action.__raw = "function() require('dap-go').debug_test() end"; options.desc = "Debug Go test"; }
        { key = "<leader>dgl"; action.__raw = "function() require('dap-go').debug_last_test() end"; options.desc = "Debug last Go test"; }
      ];

      # Auto open/close DAP UI on debug session start/end
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
  };
}
