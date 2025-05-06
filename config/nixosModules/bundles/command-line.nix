{ customModules, name }:
{ config, lib, ... }:

customModules.nixosBundle { inherit name config; } {
  nixosConfig.zoxide.enable = lib.mkDefault true;
  nixosConfig.starship.enable = lib.mkDefault true;
  nixosConfig.sops.enablePackage = lib.mkDefault true;
}
