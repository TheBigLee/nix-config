{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.nerdfetch ];

  programs.zsh.initContent = lib.mkOrder 499 "nerdfetch";
}
