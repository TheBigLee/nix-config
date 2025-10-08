{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
      };

      background = {
        path = "screenshot";
        blur_passes = 1;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      label = [
        # Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%H:%M\")</span>\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 130;
          font_family = "SF Pro Display Bold";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        # Day-Month-Date-Month
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A, %d %B\")\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 30;
          font_family = "SF Pro Display Bold";
          position = "0, 105";
          halign = "center";
          valign = "center";
        }

        # USER
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(216, 222, 233, 0.80)";
          font_size = 18;
          font_family = "SF Pro Display Bold";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      # USER-BOX
      shape = {
        monitor = "";
        size = "300, 60";
        color = "rgba(255, 255, 255, .1)";
        rounding = -1;
        border_size = 0;
        border_color = "rgba(255, 255, 255, 0)";
        rotate = 0;
        xray = false; # if true, make a "hole" in the background (rectangle of specified size, no rotation)

        position = "0, -130";
        halign = "center";
        valign = "center";
      };


      input-field = {
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(255,255,255,0)";
        inner_color = "rgba(25,25,25,0.1)";
        font_color = "rgb(200,200,200)";
        fade_on_empty = false;
        font_family = "SF Pro Display Bold";
        placeholder_text = "<i><span foreground=\"##ffffff99\">🔒 Enter Pass</span></i>";
        hide_input = false;
        position = "0, -210";
        halign = "center";
        valign = "center";
      };

    };
  };
} 