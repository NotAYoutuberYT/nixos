{
  lib,
  config,
  ...
}:

{
  options.specialConfig.bundles.desktop.enable = lib.mkEnableOption "desktop bundle";

  config.specialConfig = lib.mkIf config.specialConfig.bundles.desktop.enable {
    xdg.enable = lib.mkDefault true;

    kitty.enable = lib.mkDefault true;
    vscodium.enable = lib.mkDefault true;
    librewolf.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    nixcord.enable = lib.mkDefault true;

    ncspot.enable = lib.mkDefault true;

    waybar.enable = lib.mkDefault true;
  };
}
