{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
  };

  home.packages = with pkgs; [
    devcontainer
    devpod
    zed-editor
    jsonnet
  ];

}
