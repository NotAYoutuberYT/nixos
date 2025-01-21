{ lib, ... }:

{
  nixosConfig.autologin.enable = lib.mkDefault true;
  nixosConfig.sound.enable = lib.mkDefault true;
  nixosConfig.auto-mount.enable = lib.mkDefault true;
  nixosConfig.bluetooth.enable = lib.mkDefault true;
  nixosConfig.keepassxc.enable = lib.mkDefault true;
  nixosConfig.pavucontrol.enable = lib.mkDefault true;
  nixosConfig.okular.enable = lib.mkDefault true;
  nixosConfig.spotify.enable = lib.mkDefault true;
  nixosConfig.hyprland.enable = lib.mkDefault true;
}
