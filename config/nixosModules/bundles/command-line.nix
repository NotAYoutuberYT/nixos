{ customModules, lib, ... }:

customModules.bundle {
  nixosConfig.zoxide.enable = lib.mkDefault true;
  nixosConfig.starship.enable = lib.mkDefault true;
  nixosConfig.thefuck.enable = lib.mkDefault true;
  nixosConfig.helix.enable = lib.mkDefault true;
  nixosConfig.sops.enablePackage = lib.mkDefault true;
}
