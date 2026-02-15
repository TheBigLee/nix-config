{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bash
    btop
    claude-code
    eza   # better ls
    fd    # find replacement
    gcc
    htop
    jq
    just
    k9s
    krew
    kubecolor
    kubectl
    kubectl-split-config
    kubectx
    lazygit
    obsidian
    openshift
    opentofu
    paralus-cli
    wl-clipboard
    yq-go
    hcloud
    talosctl
    kubernetes-helm
    gitleaks
    pre-commit
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
