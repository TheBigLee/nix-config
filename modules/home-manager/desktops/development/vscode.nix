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
      #      vscodevim.vim
      bbenoist.nix
    ];
    profiles.default.userSettings = {
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.fontLigatures" = true;
      "files.insertFinalNewline" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "security.workspace.trust.untrustedFiles" = "open";
      "redhat.telemetry.enabled" = false;
      "go.toolsManagement.autoUpdate" = true;
      "dotfiles.repository" = "TheBigLee/vscode-dev-containers-dotfiles";
      "dev.containers.copyGitConfig" = false;
      "github.copilot.enable" = {
        "*" = false;
      };
      "github.copilot.editor.enableAutoCompletions" = false;
      "github.copilot.editor.enableCodeActions" = false;
      "github.copilot.nextEditSuggestions.enabled" = false;
      "github.copilot.renameSuggestions.triggerAutomatically" = false;
      "chat.commandCenter.enabled" = false;
      "chat.agent.enabled" = false;
      "claudeCode.claudeProcessWrapper" = "${pkgs.claude-code}/bin/claude";
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
        when = "editorTextFocus && !editorTabMovesFocus";
      }
    ];
  };
}
