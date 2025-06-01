{
  lib,
  pkgs,
  config,
  ...
}:

{
  options.specialConfig.bundles.desktop.enable = lib.mkEnableOption "desktop bundle";

  config = lib.mkIf config.specialConfig.bundles.desktop.enable {
    specialConfig.usb-disks.enable = lib.mkDefault true;
    specialConfig.usb-keys.enable = lib.mkDefault true;
    specialConfig.gopass.enable = lib.mkDefault true;
    specialConfig.bluetooth.enable = lib.mkDefault true;
    specialConfig.sound.enable = lib.mkDefault true;
    specialConfig.hyprland.enable = lib.mkDefault true;
    specialConfig.firefox.enable = lib.mkDefault true;
    specialConfig.git.enable = lib.mkDefault true;
    specialConfig.thunar.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      waybar
      vscodium
      spotify
      pavucontrol
      lf
      alacritty
    ];
  };
}
