{ pkgs, inputs, lib, ... }:

let
  stateVersion = "25.05";
  hostName = "Freya";
in
{
  imports = lib.flatten [
    #
    # ======= Hardware =======
    #
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen

    #
    # ====== Misc Inputs ======
    #
    (map lib.custom.relativeToRoot [
    #
    # ====== Required configs ======
    #
    "hosts/common"

    #
    # ===== System modules ======
    #
    "modules/system"
    ])
  ];

  system.stateVersion = stateVersion;

  hostSpec = {
    hostName = hostName;
    monitor = "eDP-1";
    profiles = {
      laptop.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

}
