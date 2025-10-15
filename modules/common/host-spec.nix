{ lib, ... }:

with lib; 
let
  profileModule = { name, ... }:
    {
      options = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Whether the ${name} profile is enabled.";
        };
      };
    };
in 
{
  options.hostSpec = mkOption {
    type = types.submodule {
      freeformType = with types; attrsOf str;

      options = {
        username = mkOption {
          type = types.str;
          description = "The username of the host";
        };
        name = mkOption {
          type = types.str;
          description = "The full name of the user";
        };
        hostName = mkOption {
          type = types.str;
          description = "The hostname of the host";
        };
        email = mkOption {
          type = types.attrsOf types.str;
          description = "The email of the user";
        };
        monitor = mkOption {
          type = types.str;
          description = "The name of the main monitor of the host";
        };
        profiles = mkOption {
          type = types.attrsOf (types.submodule profileModule);
          default = {};
          description = "Set of enabled profiles for this host";
        };
      };
    };
  };
}
