{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprsunset" ];

  home.packages = with pkgs; [
    hyprsunset
  ];

  services.hyprsunset = {
    enable = true;
    package = pkgs.hyprsunset;
    transitions = {
      sunrise = {
        calendar = "*-*-* 09:00:00";
        requests = [
          [ "temperature" "6500" ]
          [ "gamma 100" ]
        ];
      };
      sunset = {
        calendar = "*-*-* 19:00:00";
        requests = [
          [ "temperature" "3500" ]
          [ "gamma 50" ]
        ];
      };
    };
  };
}

