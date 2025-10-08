{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      signageos.signageos-vscode-sops
      asciidoctor.asciidoctor-vscode
      continue.continue
      ms-vscode-remote.remote-containers
      ms-azuretools.vscode-docker
      github.vscode-github-actions
      eamodio.gitlens
      golang.go
      ms-vsliveshare.vsliveshare
      ms-vscode.makefile-tools
      johnpapa.vscode-peacock
      redhat.vscode-yaml
      vscodevim.vim
      bbenoist.nix
    ];
    profiles.default.userSettings = {
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
    };
    profiles.default.keybindings = [
      {
        key = "ctrl+down";
        command = "workbench.action.terminal.focus";
      }
      {
        key = "ctrl+up";
        command = "workbench.action.focusActiveEditorGroup";
        when = "terminalFocus";
      }
      {
        key = "tab";
        command = "tab";
        when = "editorTextFocus && !editorTabMovesFocus";
      }
      {
        key = "shift+tab";
        command = "outdent";
        when = "editorTextFoucs && !editorTabMovesFocus";
      }
    ];
  };
}
