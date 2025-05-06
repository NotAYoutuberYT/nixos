{ customModules, name }:
{ config, osConfig, ... }:

let
  hex = color: "#${color}";
in
customModules.ifEnabledInNixos { inherit name osConfig; } {
  programs.alacritty = {
    enable = true;

    settings = with config.colorScheme.palette; {
      window.opacity = 0.8;
      window.dimensions = {
        lines = 0;
        columns = 0;
      };

      font.normal = {
        family = osConfig.nixosConfig.monospaceFont.name;
        style = "Regular";
      };

      cursor = {
        style = "Beam";
        thickness = 0.2;
      };

      colors = {
        primary = {
          background = hex base00;
          foreground = hex base05;
          dim_foreground = hex base04;
        };

        selection = {
          text = hex base00;
          background = hex base05;
        };

        cursor = {
          text = hex base00;
          cursor = hex base05;
        };

        hints = {
          start = {
            foreground = hex base0E;
            background = hex base0E;
          };
        };

        normal = {
          black = hex base01;
          white = hex base06;
          red = hex base08;
          green = hex base0B;
          yellow = hex base0A;
          blue = hex base0D;
          magenta = hex base0E;
          cyan = hex base0C;
        };

        bright = {
          black = hex base01;
          white = hex base06;
          red = hex base08;
          green = hex base0B;
          yellow = hex base0A;
          blue = hex base0D;
          magenta = hex base0E;
          cyan = hex base0C;
        };
      };
    };
  };
}
