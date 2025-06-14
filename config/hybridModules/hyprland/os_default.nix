{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf config.specialConfig.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    security.rtkit.enable = true;

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    security.polkit.enable = true;
    environment.systemPackages = with pkgs; [
      mako
      rofi-wayland
    ];

    programs.hyprlock.enable = true;
  };
}
