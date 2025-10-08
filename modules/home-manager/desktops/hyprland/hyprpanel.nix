{ pkgs, lib, config, ...}:
{
  programs.hyprpanel = {
    enable = true;
    settings =  {
      bar = {
        layouts = {
          "0" = {
            left = [ "dashboard" "workspaces" "windowtitle" ];
            middle = [ "notifications" "clock"];
            right = [ "cpu" "cputemp" "ram" "volume" "network" "bluetooth" "battery" "systray" "power" ];
          };
        };
        launcher.autoDetectIcon = true;
        workspaces = {
          show_icons = true;
        };
      };
      menu.clock = {
        time = {
          military = true;
          hideSeconds = false;
        };
        weather = {
          unit = "metric";
          location = "Zurich";
          key = "weather_api.json";
        };
      };
      wallpaper = {
        image = "${config.home.homeDirectory}/Pictures/Wallpapers/void_girl.png";
        enable = false;
      };
      theme = {
        matugen = true;
        matugen_settings = {
          scheme_type = "neutral";
          variation = "standard_1";
        };
        bar = {
          buttons = {
            enableBorders = false;
            opacity = 100;
            background = "#9a9996";
            monochrome = true;
            text = "#ffffff";
            icon = "#ffffff";
            background_opacity = 30;
            style = "default";
            windowtitle = {
              text = "#f5c2e7";
              icon = "#f5c2e7";
              border = "#f5c2e7";
            };
          };
          enableShadow = false;
          floating = false;
          menus = {
            popover.text = "#ffffff";
            listitems.active  = "#ffffff";
            label = "#ffffff";
            text = "#ffffff";
            icons.active = "#ffffff";
            switch.enabled = "#ffffff";
            tooltip.text = "#ffffff";
            menu = {
              network = {
                label.color = "#b4beff";
                switch.enabled = "#b4beff";
              };
              bluetooth = {
                text = "#ffffff";
                label.color = "#b4beff";
                switch.enabled = "#b4beff";
              };
              battery.label.color = "#b4beff";
              volume = {
                text = "#ffffff";
                label.color = "#b4beff";
                listitems.active = "#b4beff";
                iconbutton.active = "#b4beff";
                audio_slider.primary = "#b4beff";
                input_slider.primary = "#b4beff";
              };
              clock = {
                time.time = "#b4beff";
                time.timeperiod = "#b4beff";
                calendar = {
                  weekdays = "#5e77a7";
                  paginator = "#5e77a7";
                  currentday = "#5e77a7";
                  yearmonth = "#99c1f1";
                };
                weather = {
                  icon = "#99c1f1";
                  stats = "#99c1f1";
                  hourly = {
                    time = "#99c1f1";
                    icon = "#99c1f1";
                    temperature = "#99c1f1"; 
                  };
                  status = "#99c1f1";
                  clear = "#5e77a7";
                };
              };
            };
          };
          opacity = 30;
          transparent = false;
          workspaces = {
            show_icons = false;
            show_numbered = false;
            workspaceMask = true;
            showWsIcons = false;
            showApplicationIcons = false;
            scroll_speed = 5;
          };
        };
      };
    };
  };
}
