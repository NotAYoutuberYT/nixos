{ lib, ... }:

{
  options.specialConfig.bundles.desktop.enable = lib.mkEnableOption "desktop bundle";

  config = {
    specialConfig.gtk.enable = lib.mkDefault true;
    specialConfig.xdg.enable = lib.mkDefault true;
  };
}
