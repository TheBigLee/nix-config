{ config, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    image = "/home/${config.hostSpec.username}/Pictures/Wallpapers/void_girl.png";
    polarity = "dark";
  };
}
