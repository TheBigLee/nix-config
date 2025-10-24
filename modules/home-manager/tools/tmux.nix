{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "Space";
    mouse = true;
    historyLimit = 100000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };
  programs.tmate = {
    enable = true;
  };
}
