{ lib, pkgs, inputs, config, ... }:

{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    hyprpanel
    hypridle
    hyprlock
    wofi

    qt6.qtwayland
    qt6ct
    hyprshot
    hyprpicker
    swappy
    imv
    wf-recorder
    wlr-randr
    wl-clipboard
    wayland-utils
    wayland-protocols

    ghostty
    kitty
    zellij
    nautilus

    networkmanagerapplet
    blueman
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

}
