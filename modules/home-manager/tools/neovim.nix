{ pkgs, lib, config, ... }:
let
  flakeRoot = lib.custom.relativeToRoot "./.";
in
{
  stylix.targets.vim.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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
