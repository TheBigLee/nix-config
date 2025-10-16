{ inputs, lib, pkgs, ... }:

let
  stateVersion = "25.05";
  hostName = "NixosVm";
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
    (map lib.custom.relativeToRoot [
    #
    # ====== Required configs ======
    #
    "hosts/common"

    #
    # ===== System modules ======
    #
    "modules/system/default.nix"
    ])
  ];

  system.stateVersion = stateVersion;

  hostSpec = {
    hostName = hostName;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    cryptsetup
    pinentry-all
  ];
}
