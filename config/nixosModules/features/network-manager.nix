{ customModules, lib, ... }:

customModules.withEnableOption {
  config = {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = lib.mkDefault false;
  };
}
