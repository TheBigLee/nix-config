{ config, pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 108000;
    maxCacheTtl = 108000;
    pinentry.package = pkgs.pinentry-all;
  };
}
