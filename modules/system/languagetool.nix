{ pkgs, ... }:

let
  languagetool = pkgs.languagetool;
in {

  services.languagetool = {
    enable = true;
    package = languagetool;
  };
  environment.systemPackages = [ languagetool ];
}
