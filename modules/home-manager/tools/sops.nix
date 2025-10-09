{ inputs, pkgs, config, ... }:

let
  secretFile = (builtins.toString inputs.nix-secrets) + "/secrets.yaml";
  homeDirectory = config.home.homeDirectory;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  home.packages = with pkgs; [
    sops
  ];
  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = secretFile;
    validateSopsFiles = false;
  };
}
