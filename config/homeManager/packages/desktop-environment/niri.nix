{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

let
  hardware = osConfig.specialConfig.desktopHardware;
in
{
  options.specialConfig.niri.enable = lib.mkEnableOption "niri";

  config = lib.mkIf config.specialConfig.niri.enable {
    programs.niri = {
      # enable = true;
      package = pkgs.niri-unstable;

      settings = {
        screenshot-path = "${config.xdg.userDirs.pictures}/screenshots/%Y-%m-%d %H-%M-%S.png";

        hotkey-overlay.hide-not-bound = true;
        hotkey-overlay.skip-at-startup = true;

        clipboard.disable-primary = true;

        prefer-no-csd = true; # all my homies hate gnome

        xwayland-satellite.enable = true;

        # spawn-at-startup = TODO

        # workspaces = TODO

        input = {
          mod-key = "Super";

          focus-follows-mouse.enable = true;
          focus-follows-mouse.max-scroll-amount = "95%";

          mouse.enable = true;
          mouse.accel-profile = "flat";
          mouse.accel-speed = 1.0;

          touchpad.enable = true;
          touchpad.accel-profile = "adaptive";
          touchpad.accel-speed = 1.0;
          touchpad.click-method = "clickfinger";
          touchpad.dwt = true;
          touchpad.natural-scroll = true;
          touchpad.scroll-method = "two-finger";
          touchpad.tap = true;
          touchpad.tap-button-map = "left-right-middle";

          warp-mouse-to-focus.enable = true;
          warp-mouse-to-focus.mode = "center-xy";
        };

        outputs = builtins.listToAttrs (map (m: {
          name = m.name;
          value = {
            enable = true;
            focus-at-startup = m.primary;
            mode.width = m.resolution.x;
            mode.height = m.resolution.y;
            mode.refresh = m.refreshRate;
            position = m.position;
            scale = m.scale;
            # TODO: vrr, flipped/rotated, etc.
          };
        }) hardware.monitors);

        cursor.hide-after-inactive-ms = 4000;
        cursor.hide-when-typing = false;

        layout = {
          # border = TODO
          # focus-ring = TODO
          # insert-hint = TODO
          # preset-column-widths = TODO
          # preset-window-heights = TODO
          # tab-indicator = TODO

          center-focused-column = "on-overflow";
          default-column-display = "normal";
          default-column-width = { };

          empty-workspace-above-first = false;

          gaps = 8;
          struts.bottom = 0;
          struts.left = 0;
          struts.right = 0;
          struts.top = 0;
        };

        animations.enable = true;
        animations.slowdown = 1;

        binds =
          with config.lib.niri.actions;
          let
            focus-workspace-binds = builtins.listToAttrs (
              map (w: {
                name = "Mod+${toString w}";
                value = {
                  action = focus-workspace w;
                };
              }) (lib.range 0 9)
            );

            move-workspace-index-binds = builtins.listToAttrs (
              map (w: {
                name = "Mod+Shift+${toString w}";
                value = {
                  action = move-workspace-to-index w;
                };
              }) (lib.range 0 9)
            );
          in
          {
            "Mod+D".action.spawn = [
              "${lib.getExe pkgs.rofi}"
              "-show drun"
              "-show-icons"
            ];

            "Mod+F".action = close-window;
            "Mod+V".action = fullscreen-window;

            "Mod+H".action = focus-column-left;
            "Mod+L".action = focus-column-right;
            "Mod+J".action = focus-window-or-workspace-down;
            "Mod+K".action = focus-window-or-workspace-up;

            "Mod+Shift+H".action = move-column-left;
            "Mod+Shift+L".action = move-column-right;
            "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
            "Mod+Shift+Ctrl+J".action = move-column-to-workspace-down;
            "Mod+Shift+Ctrl+K".action = move-column-to-workspace-up;

            "Mod+Comma".action = consume-or-expel-window-left;
            "Mod+Period".action = consume-or-expel-window-right;

            "Mod+T".action = toggle-column-tabbed-display;

            "Mod+C".action = center-column;

            "Mod+M".action = focus-monitor-next;
            "Mod+N".action = focus-monitor-previous;

            "Mod+Shift+M".action = move-window-to-monitor-next;
            "Mod+Shift+N".action = move-window-to-monitor-previous;
            "Mod+Shift+Ctrl+M".action = move-column-to-monitor-next;
            "Mod+Shift+Ctrl+N".action = move-column-to-monitor-previous;
            "Super+Alt+Shift+Ctrl+M".action = move-workspace-to-monitor-next;
            "Super+Alt+Shift+Ctrl+N".action = move-workspace-to-monitor-previous;

            "Mod+G".action = maximize-column;
            "Mod+E".action = expand-column-to-available-width;
            "Mod+R".action = toggle-window-floating;

            "Mod+Y".action = toggle-overview;
          }
          // focus-workspace-binds
          // move-workspace-index-binds;
      };
    };
  };
}
