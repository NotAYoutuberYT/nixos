{ customModules, name }:
{ pkgs, config, ... }:

customModules.withNixosEnableOption { inherit config name; } {
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
    udisks
  ];
}
