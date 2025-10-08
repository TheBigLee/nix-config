{ pkgs, lib, inputs, config, ... }:
let
  secretsFile = builtins.toString inputs.nix-secrets + "/secrets.yaml";
  userName = inputs.nix-secrets.username;
  homedir = "/home/${userName}";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretsFile}";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  sops.secrets = lib.mkMerge [
    {
      "keys/age/${userName}_${config.hostSpec.hostName}" = {
        owner = config.users.users.${userName}.name;
        inherit (config.users.users.${userName}) group;
        path = "/${homedir}/.config/sops/age/keys.txt";
      };
      "passwords/${userName}".neededForUsers = true;
    }
  ];

  system.activationScripts.sopsSetAgeKeyOwnership = 
    let
      ageFolder = "${homedir}/.config/sops/age";
      user = config.users.users.${userName}.name;
      group = config.users.users.${userName}.group;
    in
    ''
      mkdir -p ${ageFolder} || true
      chown -R ${user}:${group} ${homedir}/.config
    '';
}