{ config, inputs, lib, ... }:

let
  stateVersion = "25.05";
  hostName = "Thor";
in
{
  imports = lib.flatten [
    #
    # ======= Hardware =======
    #
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

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
  };


  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
