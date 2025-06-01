{ lib, config, ... }:

{
  options.specialConfig.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf config.specialConfig.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
