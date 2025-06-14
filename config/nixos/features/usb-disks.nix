{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.usb-disks.enable = lib.mkEnableOption "usb-disks";

  config = lib.mkIf config.specialConfig.usb-disks.enable {
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs; [
      usbutils
      udiskie
      udisks
    ];
  };
}
