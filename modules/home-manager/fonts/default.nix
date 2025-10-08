{
  fonts.fontconfig.enable = true;
  home.file = {
    # Custom fonts
    ".local/share/fonts".source = ./fonts;
    ".local/share/fonts".recursive = true;
  };
}