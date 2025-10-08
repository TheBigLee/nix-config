#
{ config, lib, ... }:
{
  options = {
    nixvim-config.plugins.treesitter.enable = lib.mkEnableOption "enables treesiter module";
  };

  config = lib.mkIf config.nixvim-config.plugins.treesitter.enable {
    programs.nixvim.plugins = {
      treesiter = {
        enable = true;
        indent = true;
        folding = true;
        nixvimInjections = true;
      };
    };
  };
}
