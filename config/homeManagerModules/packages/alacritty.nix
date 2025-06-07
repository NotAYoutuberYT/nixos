{ lib, config, ... }:

{
  options.specialConfig.alacritty.enable = lib.mkEnableOption "alacritty";

  config = lib.mkIf config.specialConfig.alacritty.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        window.dimensions = {
          lines = 0;
          columns = 0;
        };

        cursor = {
          style = "Beam";
          thickness = 0.2;
        };
      };
    };
  };
}
