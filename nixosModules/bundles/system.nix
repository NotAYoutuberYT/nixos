{ lib, ... }:

{
  nixosConfig.bootloader.enable = lib.mkDefault true;
  nixosConfig.locale.enable = lib.mkDefault true;
  nixosConfig.time-zone.enable = lib.mkDefault true;
  nixosConfig.keymap.enable = lib.mkDefault true;
  nixosConfig.fonts.enable = lib.mkDefault true;

  nixosConfig.openssl.enable = lib.mkDefault true;
}
