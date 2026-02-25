{ config, ... }:
{
  sops.secrets."syncthing/gui-password" = {};

  services.syncthing = {
    enable = true;

    # Preserve devices/folders added or modified via the web UI
    overrideDevices = false;

    guiAddress = "0.0.0:8384";

    passwordFile = config.sops.secrets."syncthing/gui-password".path;

    settings = {
      gui.user = config.hostSpec.username;
      options.urAccepted = -1; # Opt out of anonymous usage reporting

      folders = {
        "obsidian" = {
          path = "/home/${config.hostSpec.username}/obsidian";
          label = "Obsidian";
        };
      };
    };

  };
}
