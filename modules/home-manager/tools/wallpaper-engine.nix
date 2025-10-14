{config, ...}:
{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = "/home/${config.hostSpec.username}/.local/share/Steam/steamapps/common/wallpaper_engine/assets";
    clamping = "border";
    wallpapers = [
      {
#        wallpaperId = "3026085319"; # japanese girl
#        wallpaperId = "1845706469"; # automata
#        wallpaperId = "2201621201"; # powerline
#        wallpaperId = "2282120494"; # cabin
        wallpaperId = "2530505367"; # void girl
        monitor = config.hostSpec.monitor;
        scaling = "fill";
        audio.silent = true;
      }
    ];
  };
}
