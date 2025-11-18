{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bash
    btop
    claude-code
    eza   # better ls
    fd    # find replacement
    htop
    jq
    just
    krew
    kubecolor
    kubectl
    kubectl-split-config
    kubectx
    obsidian
    openshift
    paralus-cli
    wl-clipboard
    yq-go
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
