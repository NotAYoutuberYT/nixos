{ customModules, name }:
{ config, lib, ... }:

customModules.nixosBundle { inherit name config; } {
  nixosConfig.usb-disks.enable = lib.mkDefault true;
  nixosConfig.usb-keys.enable = lib.mkDefault true;
  nixosConfig.bluetooth.enable = lib.mkDefault true;
  nixosConfig.spotify.enable = lib.mkDefault true;
  nixosConfig.sound.enable = lib.mkDefault true;
  nixosConfig.pavucontrol.enable = lib.mkDefault true;
  nixosConfig.hyprland.enable = lib.mkDefault true;
  nixosConfig.waybar.enable = lib.mkDefault true;
  nixosConfig.firefox.enable = lib.mkDefault true;
  nixosConfig.vscodium.enable = lib.mkDefault true;
  nixosConfig.alacritty.enable = lib.mkDefault true;
  nixosConfig.lf.enable = lib.mkDefault true;
  nixosConfig.git.enable = lib.mkDefault true;
  nixosConfig.fonts.enable = lib.mkDefault true;
}
