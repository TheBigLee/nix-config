{ lib, config, hostSpec, ... }:
{

  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
      "modules/home-manager"
      "modules/profiles/home-manager/laptop.nix"
    ])
  ];

  inherit hostSpec;

  home = {
    stateVersion = "25.05";
    username = config.hostSpec.username;
    homeDirectory = "/home/${config.hostSpec.username}";
    #file = {
    #  ".config/hypr".source = ../../../files/dotfiles/hypr;
    #  ".config/hypr".recursive = true;
    #};
  };

  profiles = config.hostSpec.profiles;

  programs.home-manager.enable = true;
}
