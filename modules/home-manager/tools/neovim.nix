{ pkgs, lib, config, ... }:
let
  flakeRoot = lib.custom.relativeToRoot "./.";
in
{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"
      require("config.options")
      require("config.lazy")
      require("config.autocmds")
      require("config.keymaps")
    '';
  };

  home.packages = with pkgs; [
    ripgrep
    delve
    lazygit
    fd
  ];

#  xdg.configFile."nvim" = {
#    source = ./neovim;
#    recursive = true;
#  };
#
#  xdg.configFile."nvim/lua/nix-env.lua" = {
#    text = ''
#      return {
#        flake_root = "${flakeRoot}",
#        hostname = "${config.hostSpec.hostName}",
#        username = "${config.hostSpec.username}",
#      }
#    '';
#  };
}
