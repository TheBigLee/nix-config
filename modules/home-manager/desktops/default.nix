{ pkgs, lib, ... }:
{
  imports = [
    ./browsers
    ./development
    ./hyprland
    ./mail
    ./generic-unstable.nix
  ];
}
