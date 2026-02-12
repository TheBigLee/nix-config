{ pkgs, lib, ... }:

{
  imports = [
    ../modules/home-manager/tools/zsh
    ../modules/home-manager/tools/nixvim
    #    ../modules/home-manager/tools/git.nix
  ];

  home = {
    username = "vscode";
    homeDirectory = "/home/vscode";
    file.".justfile".source = files/justfile;
  };

  home.packages = with pkgs; [
    eza
    just
    kind
    cookiecutter
  ];

  programs = {
    home-manager.enable = true;

    zsh = {
      history.path = "/workspaces/schedar-devcontainer/.vscode/.zsh_history";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

}
