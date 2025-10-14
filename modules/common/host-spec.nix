{ lib, ... }:
{
  options.hostSpec = lib.mkOption {
    type = lib.types.submodule {
      freeformType = with lib.types; attrsOf str;

      options = {
        username = lib.mkOption {
          type = lib.types.str;
          description = "The username of the host";
        };
        name = lib.mkOption {
          type = lib.types.str;
          description = "The full name of the user";
        };
        hostName = lib.mkOption {
          type = lib.types.str;
          description = "The hostname of the host";
        };
        email = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          description = "The email of the user";
        };
        monitor = lib.mkOption {
          type = lib.types.str;
          description = "The name of the main monitor of the host";
        };
      };
    };
  };
}
