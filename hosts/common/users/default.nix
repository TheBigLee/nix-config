{ pkgs, lib, config, inputs, ... }:
let
  hostSpec = config.hostSpec;
  sopsHashedPasswordFile = config.sops.secrets."passwords/${hostSpec.username}".path;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  sops.secrets = {
    "passwords/${hostSpec.username}" = {
      neededForUsers = true;
    };
  };
  users = {
    users.${hostSpec.username} = {
      isNormalUser = true;
      description = hostSpec.name;
      extraGroups = 
        let
          ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
        in
        lib.flatten [
        "wheel"
        (ifTheyExist [
          "input"
          "networkmanager"
          "plugdev"
          "wheel"
          "users"
          "docker"
        ])
      ];
      shell = pkgs.zsh;
      hashedPasswordFile = sopsHashedPasswordFile;
      home = "/home/${hostSpec.username}";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5cVc/FNIWZ24dA0147cXiCEWW/vkRNI0CCPi+13m21 main@2025"
      ];
    };
    groups.${hostSpec.username} = {};
  };
  
  home-manager = 
    {
      extraSpecialArgs = {
        inherit pkgs inputs;
        hostSpec = config.hostSpec;
      };
      users.${hostSpec.username} = import (lib.custom.relativeToRoot "home/");
    };
}
