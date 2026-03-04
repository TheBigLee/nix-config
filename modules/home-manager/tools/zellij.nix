{ pkgs, ... }:
let
  zellij-autolock = pkgs.fetchurl {
    url = "https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm";
    sha256 = "194fgd421w2j77jbpnq994y2ma03qzdlz932cxfhfznrpw3mdjb9";
  };
in
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  # Show current kube-context as the zellij pane title via OSC terminal title escape
  programs.zsh.initContent = ''
    function _zellij_kube_title() {
      if [[ -n "$ZELLIJ" ]]; then
        local ctx
        ctx=$(kubectl config current-context 2>/dev/null)
        if [[ -n "$ctx" ]]; then
          printf "\033]0;%s\007" "$ctx"
        fi
      fi
    }
    precmd_functions+=(_zellij_kube_title)
  '';

  xdg.configFile."zellij/config.kdl".text = ''
    plugins {
        autolock location="file:${zellij-autolock}" {
            triggers "nvim"
            reaction_seconds "0"
        }
    }

    load_plugins {
        autolock
    }

    show_startup_tips false
  '';
}
