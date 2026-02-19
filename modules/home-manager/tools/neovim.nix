{ pkgs, lib, config, ... }:
let
  flakeRoot = lib.custom.relativeToRoot "./.";

  # Path to the nix-config repo — can be overridden via hostSpec.nixConfigPath
  nixConfigPath = if config.hostSpec.nixConfigPath != ""
                  then config.hostSpec.nixConfigPath
                  else "${config.home.homeDirectory}/dev/nix/nix-config";

  # Path to your dotfiles in the git repo (absolute path for out-of-store symlinks)
  dotfilesPath = "${nixConfigPath}/files/dotfiles";
in
{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    delve
    fd
    gcc
    gopls
    jsonnet-language-server
    lazygit
    lua-language-server
    nodejs
    ripgrep
    unzip
    vscode-langservers-extracted  # jsonls, htmlls, cssls, eslint
    yaml-language-server
  ];

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/neovim";
    };
  };

  #xdg.configFile."nvim/lua/nix-env.lua" = {
  #  text = ''
  #    return {
  #      flake_root = "${flakeRoot}",
  #      hostname = "${config.hostSpec.hostName}",
  #      username = "${config.hostSpec.username}",
  #    }
  #  '';
  #};
}
