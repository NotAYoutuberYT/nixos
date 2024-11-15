{ lib, ... }:

{
  homeManagerConfig.firefox.enable = lib.mkDefault true;
  homeManagerConfig.vscodium.enable = lib.mkDefault true;
  homeManagerConfig.alacritty.enable = lib.mkDefault true;
  homeManagerConfig.element.enable = lib.mkDefault true;
  homeManagerConfig.lf.enable = lib.mkDefault true;
  homeManagerConfig.gtk.enable = lib.mkDefault true;
}
