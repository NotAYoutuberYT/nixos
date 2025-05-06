{ customModules, name }:
{ config, lib, ... }:

customModules.homeManagerBundle { inherit name config; } {
  homeManagerConfig.gtk.enable = lib.mkDefault true;
  homeManagerConfig.xdg.enable = lib.mkDefault true;
}
