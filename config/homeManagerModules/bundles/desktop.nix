{ customModules, lib, ... }:

customModules.bundle {
  homeManagerConfig.gtk.enable = lib.mkDefault true;
  homeManagerConfig.xdg.enable = lib.mkDefault true;
}
