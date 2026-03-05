{ config, lib, pkgs, ... }:
let
  hasNvidia = lib.elem "nvidia" (config.services.xserver.videoDrivers or []);
  acceleration = if hasNvidia then "cuda" else "vulkan";
in
{
  environment.systemPackages = with pkgs.unstable; [
    ollama
  ];

  services.ollama = {
    package = pkgs.unstable.ollama;
    enable = true;
    inherit acceleration;
    host = "0.0.0.0";
    port = 11434;
  };
}
