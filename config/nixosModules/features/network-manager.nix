{ customModules, name }:
{ lib, config, ... }:

customModules.withNixosEnableOption { inherit name config; } {
  config = {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = lib.mkDefault false;
  };
}
