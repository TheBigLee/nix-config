{ ... }:
{

  programs.ssh = {
    enable = true;
    compression = true;
    extraConfig = ''
      IdentitiesOnly yes
      IdentityFile ~/.ssh/id_ed25519_2025
      Include sshop_config
    '';
  };

}
