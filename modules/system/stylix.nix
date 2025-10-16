{ pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
    url = "https://github.com/TheBigLee/nix-config/blob/main/files/system/stylix/wallpapers/void_girl.png?raw=true";
    hash = "sha256-zAQehTgMMQ9z8DK2HRwAVvVjUb6xhiMrsOmfrIRJUrI=";
    };
    polarity = "dark";
  };
}
