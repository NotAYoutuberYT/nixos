{ config, ... }:

{
  config = {
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

        background = {
          blur_passes = 2;
          blur_size = 4;
        };

        label = [
          {
            position = "0, 200";
            halign = "center";
            valign = "center";
            text = "hi, $USER";
            font_size = 25;
            font_family = config.stylix.fonts.monospace.name;
          }
        ];

        input-field = {
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
          font_family = config.stylix.fonts.monospace.name;

          fail_text = "";
          fail_timeout = 2000;
          fail_transition = 300;
        };
      };
    };
  };
}
