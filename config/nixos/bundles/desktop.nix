{ lib, config, ... }:

{
  options.specialConfig.bundles.desktop.enable = lib.mkEnableOption "desktop bundle";

  config = lib.mkIf config.specialConfig.bundles.desktop.enable {
    specialConfig.usb-disks.enable = lib.mkDefault true;
    specialConfig.usb-keys.enable = lib.mkDefault true;
    specialConfig.bluetooth.enable = lib.mkDefault true;
    specialConfig.sound.enable = lib.mkDefault true;
    specialConfig.ly.enable = lib.mkDefault true;
    specialConfig.thunar.enable = lib.mkDefault true;

    specialConfig.niri.enable = lib.mkDefault true;
  };
}
