{ config, lib, ... }:

let
  cfg = config.homeManagerConfig.hyprland;

  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      settings = with config.colorScheme.palette; {
        general = {
          disable_loading_bar = true;

          grace = 1;
          hide_cursor = true;

          no_fade_in = false;
          no_fade_out = false;

          ignore_empty_input = true;
        };

        background = [
          {
            path = "${./wallpaper.png}";
            blur_passes = 2;
            blur_size = 4;
          }
        ];

        label = [
          {
            position = "0, 200";
            halign = "center";
            valign = "center";
            text = "hi, $USER";
            font_size = 25;
            font_family = "JetBrainsMono NF";
            font_color = rgb base05;
          }
        ];

        input-field = [
          {
            size = "180, 45";
            position = "0, 120";
            dots_center = true;
            dots_size = 0.15;
            rounding = 5;
            outline_thickness = 3;
            shadow_passes = 2;
            fade_on_empty = true;
            fade_timeout = 1000;
            placeholder_text = "";

            font_family = "JetBrainsMono NF";
            font_color = rgb base05;
            inner_color = rgba base01 "20";
            outer_color = rgba base00 "30";
            fail_color = rgba base08 "25";
            check_color = rgba base0A "25";

            fail_text = "";
            fail_timeout = 2000;
            fail_transition = 300;
          }
        ];
      };
    };
  };
}
