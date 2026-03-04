{
  config,
  lib,
  pkgs,
  ...
}:
  
{
  services.unifi = {
    enable = true;
    openFirewall = true;
  };
}
