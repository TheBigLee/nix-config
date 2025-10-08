#
{ config, lib, ... }:
{
  options = {
    nixvim-config.plugins.treesitter.enable = lib.mkEnableOption "enables treesiter module";
  };

  config = lib.mkIf config.nixvim-config.plugins.treesitter.enable {
    programs.nixvim.plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          diff
          dockerfile
          git_config
          git_rebase
          gitcommit
          gitignore
          go
          hyprlang
          jq
          json
          jsonnet
          lua
          make
          markdown
          nix
          passwd
          python
          regex
          ssh_config
          toml
          vim
          vimdoc
          yaml
        ];
        indent = true;
        folding = true;
        nixvimInjections = true;
      };
    };
  };
}
