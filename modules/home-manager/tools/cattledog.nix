{ config, lib, ... }:
{
  sops.secrets = {
    "cattledog/url" = {};
    "cattledog/access_key" = {};
    "cattledog/secret_key" = {};
  };

  programs.zsh = {
    initContent = lib.mkMerge [
      (lib.mkBefore ''
       export CATTLEDOG_API_URL="$(cat ${config.sops.secrets."cattledog/url".path})"
       export CATTLEDOG_ACCESS_KEY="$(cat ${config.sops.secrets."cattledog/access_key".path})"
       export CATTLEDOG_SECRET_KEY="$(cat ${config.sops.secrets."cattledog/secret_key".path})"
      '')
    ];
  };
}
