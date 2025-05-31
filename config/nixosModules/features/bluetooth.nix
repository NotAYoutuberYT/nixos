{ lib, ... }:

{
  options.specialConfig.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
