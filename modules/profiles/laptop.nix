{ config, lib, pkgs, ... }:
let
  cfg = config.profiles.laptop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.laptop.enable = mkEnableOption "Laptop tools";
  config = mkIf cfg.enable {
  };
}
