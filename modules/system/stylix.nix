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
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.fira-code;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
