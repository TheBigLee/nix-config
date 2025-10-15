{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    blueman
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
