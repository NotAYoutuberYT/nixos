{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.bundles.desktop.enable = lib.mkEnableOption "desktop bundle";

  config = lib.mkIf config.specialConfig.bundles.desktop.enable {
    specialConfig = {
      xdg.enable = lib.mkDefault true;

      alacritty.enable = lib.mkDefault true;
      vscodium.enable = lib.mkDefault true;
      firefox.enable = lib.mkDefault true;

      ncspot.enable = lib.mkDefault true;

      waybar.enable = lib.mkDefault true;
    };

    environment.systemPackages = [
      pkgs.cm_unicode
      pkgs.corefonts
    ];
  };
}
