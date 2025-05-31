{ pkgs, lib, ... }:

{
  options.specialConfig.usb-disks.enable = lib.mkEnableOption "usb-disks";

  config = {
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs; [
      usbutils
      udiskie
      udisks
    ];
  };
}
