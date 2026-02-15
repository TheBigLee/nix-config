{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.lsp_signature-nvim ];

    extraConfigLua = ''
      require("lsp_signature").setup({
        floating_window = true,
        hint_prefix = " ",
        handler_opts = {
          border = "rounded",
        },
      })
    '';
  };
}
