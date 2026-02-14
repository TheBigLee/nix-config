{ ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
      };
      extensions = [ "neo-tree" "nvim-dap-ui" "overseer" "toggleterm" ];
    };
  };
}
