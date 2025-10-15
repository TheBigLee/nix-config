{ config, lib, ... }:
let
  cfg = config.profiles.laptop;
  inherit (lib) mkEnableOption mkIf;
in
{

  options.profiles.laptop.enable = mkEnableOption "Laptop tools";
  config = mkIf cfg.enable {
    home.file = {
      ".config/hypr/handle_lid_swith.sh".source = (lib.custom.relativeToRoot "files/home-manager/laptop/handle_lid_switch.sh");
    };
    wayland.windowManager.hyprland = {
      settings = {
        bindl = [
          ",switch:on:Lid Switch, exec, ~/.config/hypr/handle_lid_switch.sh"
          ",switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, enable\""
        ];
      };
    };
  };
}
