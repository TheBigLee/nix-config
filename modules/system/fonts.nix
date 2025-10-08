{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg

      openmoji-color
      twemoji-color-font
    ];

    enableDefaultPackages = false;


    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Inter" "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font" "Not Sans Mono" ];
        emoji = [ "Noto Color Emoji" "OpenMoji Color" ];
      };
    };
  };
}
