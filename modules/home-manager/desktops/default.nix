{ pkgs, lib, ... }:
{
  imports = [
    ./browsers
    ./development
    ./hyprland
    ./mail
    ./zoom
  ];
}
