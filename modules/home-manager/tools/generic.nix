{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd    # find replacement
    eza   # better ls
    btop
    htop
    kubectl
    kubectx
    openshift
    krew
    paralus-cli
    kubectl-split-config
    jq
    yq-go
    ferdium
    obsidian
  ];

  programs = {
    # required by comma
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd" # replace cd with z and zi (via cdi)
      ];
    };

    pay-respects = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--alias fuck"
      ];
    };

  };
}
