{ pkgs, lib, inputs, config, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
    ../modules/common/host-spec.nix
    ../modules/home-manager/tools/sops.nix
    ../modules/home-manager/tools/zsh
    ../modules/home-manager/tools/nixvim
    #    ../modules/home-manager/tools/git.nix
  ];

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://github.com/TheBigLee/nix-config/blob/main/files/system/stylix/wallpapers/void_girl.png?raw=true";
      hash = "sha256-zAQehTgMMQ9z8DK2HRwAVvVjUb6xhiMrsOmfrIRJUrI=";
    };
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.fira-code;
        name = "FiraCode Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  # Define hostSpec for devcontainer context
  hostSpec = {
    username = "vscode";
    name = "DevContainer User";
    hostName = "devcontainer";
    email = {
      primary = "dev@example.com";
    };
    monitor = "";
  };

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
    kitty
  ];

  programs = {
    home-manager.enable = true;

    zsh = {
      history.path = "/workspaces/schedar-devcontainer/.vscode/.zsh_history";
    };
  };

  # Disable dconf in devcontainer (no dbus available)
  dconf.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

}
