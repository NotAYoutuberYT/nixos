{ lib, config, ... }:

{
  options.specialConfig.usb-keys.enable = lib.mkEnableOption "usb-keys";

  config = lib.mkIf config.specialConfig.usb-keys.enable {
    services.pcscd.enable = true;
  };
}
