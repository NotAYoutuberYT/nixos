{ customModules, name }:
{ config, ... }:

customModules.withNixosEnableOption { inherit name config; } {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
