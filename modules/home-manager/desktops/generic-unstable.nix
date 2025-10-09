{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    ferdium
    zoom-us
  ];
}
