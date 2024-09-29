{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

{
  homeManagerConfig = {
    bundles.desktop.enable = true;

    hyprland.sensitivity = "-0.65";
    hyprland.monitors = [
      "DP-6, 3840x2160@144, 0x0, 1"
      "DP-4, 2560x1440@170, 3840x0, 1"
    ];
  };

  home.username = "bryce";
  home.homeDirectory = "/home/bryce";
  home.stateVersion = "24.05";

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
