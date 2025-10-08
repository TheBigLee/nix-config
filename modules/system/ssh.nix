{ config, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ config.hostSpec.username ];
      PermitRootLogin = "prohibit-password";
    };
  };
}
