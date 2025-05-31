{ lib, ... }:

{
  options.specialConfig.network-manager.enable = lib.mkEnableOption "network-manager";

  config = {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = lib.mkDefault false;
  };
}
