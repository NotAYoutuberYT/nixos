{ lib, ... }:

{
  options.specialConfig.usb-keys.enable = lib.mkEnableOption "usb-keys";

  config = {
    services.pcscd.enable = true;
  };
}
