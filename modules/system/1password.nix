{ config, inputs, pkgs, ... }:
{
  imports = [ inputs._1password-shell-plugins.nixosModules.default ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ config.hostSpec.username ];
  };

  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      gh
    ];
  };
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
        zen
      '';
      mode = "0755";
    };
  };
}
