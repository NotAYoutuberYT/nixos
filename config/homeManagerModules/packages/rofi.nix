{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.rofi.enable = lib.mkEnableOption "rofi";

  config = lib.mkIf config.specialConfig.rofi.enable {
    programs.rofi = {
      enable = true;

      location = "center";
      terminal = "${lib.getExe pkgs.kitty}";
    };
  };
}
