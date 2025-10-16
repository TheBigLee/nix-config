{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi --show drun";


      "$cursor_theme" = "phinger-cursors-dark";
      "$cursor_size" = 24;

      # Monitors
      monitor = ", highres, auto, 1";

      general = {
        resize_on_border = false;
        layout = "dwindle";
      };


      # Autostart
      exec-once = [
        "ferdium"
      ];

      animations = {
        enabled = "yes";
      };

      decoration = {
        active_opacity = "1.0";
        inactive_opacity = "0.9";
        rounding = 10;

        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 18;
          passes = 1;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };

      master = {
        new_status = "master";
        allow_small_split = true;
        mfact = 0.5;
      };

      misc = {
        vfr = true;
        force_default_wallpaper = 2;
        disable_autoreload = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      input = {
        kb_layout = "ch";
        kb_options = "nodeadkeys";
        follow_mouse = 1;
        sensitivity = "0.5";
        numlock_by_default = true;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, $menu"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, zen"
        "$mod, L, exec, hyprlock"
        "$mod, M, exit"
        "$mod, T, togglefloating"
        "$mod, F, fullscreen"
        "$mod, P, pseudo" # dwindle
        "$mod, J, togglesplit" # dwindle

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$shiftmod, left, movewindow, l"
        "$shiftmod, right, movewindow, r"
        "$shiftmod, up, movewindow, u"
        "$shiftmod, down, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"
        "$mod, S, togglespecialworkspace"
        
        "$mod, KP_End, workspace, 1"
        "$mod, KP_Down, workspace, 2"
        "$mod, KP_Next, workspace, 3"
        "$mod, KP_Left, workspace, 4"
        "$mod, KP_Begin, workspace, 5"
        "$mod, KP_Right, workspace, 6"
        "$mod, KP_Home, workspace, 7"
        "$mod, KP_Up, workspace, 8"
        "$mod, KP_Prior, workspace, 9"
        "$mod, KP_Insert, workspace, 0"
        
        "$mod $shiftmod, 1, movetoworkspace, 1"
        "$mod $shiftmod, 2, movetoworkspace, 2"
        "$mod $shiftmod, 3, movetoworkspace, 3"
        "$mod $shiftmod, 4, movetoworkspace, 4"
        "$mod $shiftmod, 5, movetoworkspace, 5"
        "$mod $shiftmod, 6, movetoworkspace, 6"
        "$mod $shiftmod, 7, movetoworkspace, 7"
        "$mod $shiftmod, 8, movetoworkspace, 8"
        "$mod $shiftmod, 9, movetoworkspace, 9"
        "$mod $shiftmod, 0, movetoworkspace, 0"

        "$mod $shiftmod, KP_End, movetoworkspace, 1"
        "$mod $shiftmod, KP_Down, movetoworkspace, 2"
        "$mod $shiftmod, KP_Next, movetoworkspace, 3"
        "$mod $shiftmod, KP_Left, movetoworkspace, 4"
        "$mod $shiftmod, KP_Begin, movetoworkspace, 5"
        "$mod $shiftmod, KP_Right, movetoworkspace, 6"
        "$mod $shiftmod, KP_Home, movetoworkspace, 7"
        "$mod $shiftmod, KP_Up, movetoworkspace, 8"
        "$mod $shiftmod, KP_Prior, movetoworkspace, 9"
        "$mod $shiftmod, KP_Insert, movetoworkspace, 0"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screnshots
        "$mod, PRINT, exec, hyprshot -m region"
        ", PRINT, exec, hyprshot -m output"
        "$shiftMod, PRINT, exec, hyprshot -m window"
      ];

      bindm = [
        # Move/resize window with SUPER + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
      bindle = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      env = [
        "NIXOS_OZONE_WL, 1" # for ozone-based and electron apps to run on wayland
        "MOZ_ENABLE_WAYLAND, 1" # for firefox to run on wayland
        "MOZ_WEBRENDER, 1" # for firefox to run on wayland
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_QPA_PLATFORM,wayland"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor" # this will be better than default for now
      ];
      windowrulev2 = [
        "float, class:^(zoom)$"
        "float, class:^(steam)$"
        "float, class:^(1Password)$"
        "workspace special, class:^(ferdium)$"
      ];
    };
  };
  programs = {
    home-manager.enable = true;

    zsh = {
      oh-my-zsh = {
        theme = "gentoo";
      };
    };
  };
}
