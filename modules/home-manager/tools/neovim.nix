{ pkgs, lib, config, ... }:
let
  flakeRoot = lib.custom.relativeToRoot "./.";
  treesitterParsers = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
    bash
    diff
    dockerfile
    git_config
    git_rebase
    gitcommit
    gitignore
    go
    hyprlang
    jq
    json
    jsonnet
    lua
    make
    markdown
    nix
    python
    regex
    ssh_config
    toml
    vim
    vimdoc
    yaml
  ]);
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
    delve
    fd
    gcc
    gopls
    lazygit
    ripgrep
  ];
  xdg.configFile."nvim" = {
    source = ./neovim;
    recursive = true;
  };

  xdg.configFile."nvim/lua/nix-env.lua" = {
    text = ''
      return {
        flake_root = "${flakeRoot}",
        hostname = "${config.hostSpec.hostName}",
        username = "${config.hostSpec.username}",
        treesitter_parser_dir = "${treesitterParsers}/parser",
      }
    '';
  };
}
