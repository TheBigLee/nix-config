{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
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
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
    nixvimInjections = true;
  };

  programs.nixvim.plugins.treesitter-context = {
    enable = true;
    settings = {
      max_lines = 3;
    };
  };
}
