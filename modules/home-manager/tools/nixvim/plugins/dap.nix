# Debug Adapter Protocol (DAP) plugins
{ config, lib, ... }:
{
  options = {
    nixvim-config.plugins.dap.enable = lib.mkEnableOption "enables DAP debugging module";
  };

  config = lib.mkIf config.nixvim-config.plugins.dap.enable {
    programs.nixvim.plugins = {
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

      # nvim-nio - nvim-neotest/nvim-nio (async IO library, dependency for dap-ui)
      nvim-nio = {
        enable = true;
      };
    };
  };
}
