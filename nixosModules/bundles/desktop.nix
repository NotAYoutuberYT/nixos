{ pkgs, lib, ... }:

{
  nixosConfig.sddm.enable = lib.mkDefault true;
  nixosConfig.extended-fonts.enable = lib.mkDefault true;
  nixosConfig.desktop-apps.enable = lib.mkDefault true;
  nixosConfig.vscodium.enable = lib.mkDefault true;
  nixosConfig.sound.enable = lib.mkDefault true;
  nixosConfig.tex.enable = lib.mkDefault true;
  nixosConfig.okular.enable = lib.mkDefault true;
  nixosConfig.auto-mount.enable = lib.mkDefault true;

  nixosConfig.hyprland.enable = lib.mkDefault true;
}
