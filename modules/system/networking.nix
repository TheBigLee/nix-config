{ config, lib, ... }:

{
  options.hostName = lib.mkOption {
    type = lib.types.str;
    description = "Host name for this system.";
  };

  config = {
    networking.hostName = config.hostSpec.hostName; # Define your hostname.
    networking.networkmanager.enable = true; # Use networkmanager
  };
}
