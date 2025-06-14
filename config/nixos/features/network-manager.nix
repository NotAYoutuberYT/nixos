{ lib, config, ... }:

{
  options.specialConfig.network-manager.enable = lib.mkEnableOption "network-manager";

  config = lib.mkIf config.specialConfig.network-manager.enable {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = lib.mkDefault false;
  };
}
