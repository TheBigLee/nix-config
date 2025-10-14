{ config, inputs, lib, ... }:

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
    inputs.stylix.nixosModules.stylix

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
  };


  hardware.graphics = {
    enable = true;
  };
}
