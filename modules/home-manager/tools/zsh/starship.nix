{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    settings = {
      #      format = "$all$nix_shell$golang$git_branch$git_commit$git_state$git_status\n $directory";
      format = "[](bg:#030B16 fg:#7DF9AA)[ ](bg:#7DF9AA fg:#090c0c)[](fg:#1C3A5E bg:#3B76F0)$directory[](fg:#3B76F0 bg:#FCF391)$git_branch$git_status$git_metrics";
      #      format = ''
      #[┌───────────────────>](bold green)
      #[│](bold green)$directory$rust$package
      #[└─>](bold green) 
      #  '';
      right_format = "$character[](fg:#FCF392)$cmd_duration[]kubernetes";
      character = {
        success_symbol = "[ ➜](bold green) ";
        error_symbol = "[ ✗](#E84D44) ";
      };
      directory = {
        truncation_length = 8;
        truncate_to_repo = false;
        use_logical_path = true;
        format = "[   $path ]($style)";
        style = "fg:#E4E4E4 bg:#3B76F0";
      };
      golang = {
        style = "bold white";
      };
      git_status = {
        format = "[$all_status]($style)";
        style = "fg:#1C3A5E bg:#FCF392";
      };
      git_branch = {
        format = "[ $symbol$branch(:$remote_branch) ]($style)";
        symbol = "  ";
        style = "fg:#1C3A5E bg:#FCF392";
      };
      git_metrics = {
        format = "([+$added]($added_style))[]($added_style)[](fg:#FCF392)";
        added_style = "fg:#1C3A5E bg:#FCF392";
        deleted_style = "fg:bright-red bg:235";
        disabled = false;
      };

      hg_branch = {
        format = "[ $symbol$branch ]($style)";
        symbol = " ";
      };

      cmd_duration = {
        format = "[ $duration  ]($style)";
        style = "fg:bright-white bg:18";
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#1d2230";
        format = "[[ 󱑍 $time ](bg:#1C3A5E fg:#8DFBD2)]($style)";
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( \($namespace\))]($style)";
        detect_env_vars = [
          "KUBECONFIG"
        ];
        style = "white bold";
        contexts = [
          { 
            context_pattern = "*kind*";
            style = "green bold";
            symbol = "📚 ";
          }
          {
            context_pattern = "*dev*";
            style = "green bold";
            symbol = "🔵 ";
          }
          {
            context_pattern = "*test*";
            style = "yellow bold";
            symbol = "🟡 ";
          }
          {
            context_pattern = "*prod*";
            style = "red bold";
            symbol = "🔴 ";
          }
        ];
      };
    };
  };
}
