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

    hyprland.sensitivity = "0.0";
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
