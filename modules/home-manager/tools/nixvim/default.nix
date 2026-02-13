{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./plugins
    ./keymaps.nix
  ];

  stylix.targets.nixvim.transparentBackground = {
    main = true;
    signColumn = true;
    numberLine = true;
  };

  programs.nixvim = {
    enable = true;
    enableMan = true;

    clipboard.register = "unnamedplus";

    opts = {
      # Appearance
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      cursorline = true;
      termguicolors = true;

      # Indentation
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # Behavior
      hidden = true;
      wrap = false;
      scrolloff = 8;
      sidescrolloff = 8;
      splitbelow = true;
      splitright = true;

      # Backup/swap
      backup = false;
      writebackup = false;
      swapfile = false;
      undofile = true;
    };
  };
}
