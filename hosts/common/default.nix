{ inputs, outputs, lib, pkgs, ...}:
{

  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager

    (map lib.custom.relativeToRoot [
      "modules/common"
      "hosts/common/users"
    ])
  ];

  hostSpec = {
    inherit (inputs.nix-secrets)
      username
      name
      email
      ;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    cryptsetup
    pinentry-all
  ];

  # I use zsh btw
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  fonts.fontDir.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";

  nixpkgs = {
    overlays = [
      outputs.overlays.default 
    ];
    config = {
      allowUnfree = true;
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    randomizedDelaySec = "45min";
    flags = [
      "--refresh"
      "-L" # print build logs 
    ];
    flake = inputs.self.outPath;
  };

}
