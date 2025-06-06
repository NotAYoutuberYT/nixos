{ lib, config, ... }:

{
  options.specialConfig.ncspot.enable = lib.mkEnableOption "ncspot";

  config = lib.mkIf config.specialConfig.ncspot.enable {
    programs.ncspot = {
      enable = true;

      settings.keybindings = {
        "d" = "noop";
      };
    };
  };
}
