{
  inputs,
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
    environment.sessionVariables.HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    environment.sessionVariables.XCURSOR_SIZE = "24";
    environment.sessionVariables.HYPRCURSOR_SIZE = "24";

    security.polkit.enable = true;
    environment.systemPackages = with pkgs; [
      mako
      swww
      rofi-wayland
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ];

    programs.hyprlock.enable = true;
  };
}
