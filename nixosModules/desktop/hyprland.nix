{ pkgs, lib, inputs, config, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
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
    polkit_gnome
    waybar
    mako
    rofi-wayland
    swww
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
}