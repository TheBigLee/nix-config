{ config, pkgs, lib, ... }:
let
  isDevcontainer = config.hostSpec.hostName == "devcontainer";
in
{
  #imports = [
  #  ./starship.nix
  #];

  sops.secrets = lib.mkIf (!isDevcontainer) {
    "tofu_state" = {};
  };

  home.packages = with pkgs; [
    rmtrash
    fzf   # fuzzy finder
    comma # run ", command" tu run a cmd in a temp nix shell
  ];

  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory + "/.config/zsh";
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autocd = true;
    history = {
      size = 100000;
      share = true;
      ignoreDups = true;
    };

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh.theme";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      (lib.mkAfter (lib.readFile ./zshrc))
      (lib.mkAfter (lib.readFile ./functions.zsh))
      (lib.mkAfter (lib.readFile ./completions.zsh))
      (lib.mkAfter ''
        # Load aliases from cluster repo.
        if [[ -d ''${CLUSTER_BASE_DIR:-''${HOME}/dev/vshn/openshift4-clusters} ]]; then
          for ALIAS in ''${CLUSTER_BASE_DIR:-''${HOME}/dev/vshn/openshift4-clusters}/.aliases/*; do
            source ''${ALIAS}
          done
        fi
        export CLUSTER_BASE_DIR=''${HOME}/dev/vshn/openshift4-clusters

        export KUBE_EDITOR="nvim"
        compdef kubecolor=kubectl

        export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
        ${lib.optionalString (!isDevcontainer) ''export TOFU_STATE_ENCRYPTION="$(cat ${config.sops.secrets."tofu_state".path})"''}
      '')
    ];

    shellAliases = import ./aliases.nix;

    sessionVariables = {
      NIX_AUTO_RUN = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "command-not-found"
        "cp"
        "direnv"
        "git"
        "sudo"
        "systemd"
      ];
      extraConfig = lib.mkMerge [
        (lib.mkBefore ''
          # Display red dots while waiting for completion.
          COMPLETION_WAITING_DOTS="true"
        '')
      ];
    };
  };
}

