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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBT8mlBe9dtarqd3vcrBw9zQzz2ktXAVqtVBVE/4ClAL main@2026"
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
