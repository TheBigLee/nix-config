{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gnumake
  ];
}
