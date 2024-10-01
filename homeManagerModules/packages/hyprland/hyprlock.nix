{ config, lib, ... }:

let
  cfg = config.homeManagerConfig.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
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
            path = "screenshot";
            blur_passes = 2;
            blur_size = 6;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, 120";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
