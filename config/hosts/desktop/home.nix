{ ... }:

{
  homeManagerConfig = {
    hyprland.sensitivity = "-0.65";
    hyprland.no-hardware-cursor = true;
    hyprland.monitors = [
      "DP-6, 3840x2160@144, 0x0, 1"
      "DP-4, 2560x1440@170, 3840x0, 1"
    ];
    hyprland.workspaces = [
      "1, monitor:DP-6"
      "2, monitor:DP-4"
    ];

    bundles.desktop.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nano";
  };
}
