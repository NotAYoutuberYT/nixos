{ ... }:

{
  specialConfig = {
    hyprland.sensitivity = "-0.65";
    hyprland.hw-cursor-cpu-buffer = true;

    hyprland.workspaces = [
      "1, monitor:DP-3"
      "2, monitor:DP-1"
    ];

    bundles = {
      desktop.enable = true;
      command-line.enable = true;
    };
  };
}
