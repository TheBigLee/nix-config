{ pkgs, config, inputs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut;
  #  sddm-astronaut = pkgs.sddm-astronaut.override {
  #    themeConfig = {
  #      Background = "${config.hostSpec.username}/Pictures/Wallpapers/void_girl.png";
  #    };
  #  };
in {
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = config.hostSpec.username;
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = [
        sddm-astronaut
      ];
      theme = "sddm-astronaut-theme";
        #settings = {
        #  Wayland.SessionDir = "${
        #   inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland
        #  }/share/wayland-sessions";
        #};
    };
  };

  environment.systemPackages = [sddm-astronaut];
}
