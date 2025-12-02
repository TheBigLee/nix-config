{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprsunset" ];

  home.packages = with pkgs; [
    hyprsunset
  ];

  services.hyprsunset = {
    enable = true;
    package = pkgs.hyprsunset;
    settings = {
      profile = [
        {
          time = "09:00";
          temperature = 6650;
          gamma = 100;
        }
        {
          time = "19:00";
          temperature = 3500;
          gamma = 50;
        }
      ];
    };
  };
}

