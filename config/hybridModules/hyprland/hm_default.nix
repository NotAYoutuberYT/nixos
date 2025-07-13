{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

let
  cfg = config.specialConfig.hyprland;
  hardware = osConfig.specialConfig.desktopHardware;

  startupScript = pkgs.pkgs.writeShellScriptBin "startup" ''
    ${pkgs.waybar}/bin/waybar & ${lib.getExe pkgs.wbg} ${config.stylix.image}
  '';
in
{
  options.specialConfig.hyprland = {
    sensitivity = lib.mkOption {
      type = lib.types.str;
      default = "0.0";
      description = "sensitivity, from -1.0 to 1.0";
    };

    acceleration-profile = lib.mkOption {
      type = lib.types.str;
      default = "flat";
      description = "mouse acceleration";
    };

    hw-cursor-cpu-buffer = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  imports = lib.optional osConfig.specialConfig.hyprland.enable ./hm_hyprlock.nix;

  config = lib.mkIf osConfig.specialConfig.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$terminal" = "${lib.getExe pkgs.kitty}";
        "$fileManager" = "${lib.getExe pkgs.kitty} ${lib.getExe pkgs.yazi}";
        "$menu" = "${lib.getExe pkgs.rofi-wayland} -show drun -show-icons";
        "$lock" = "${lib.getExe pkgs.hyprlock}";

        exec-once = [ "${lib.getExe startupScript}" ];

        monitor =
          [ ", preferred, auto, 1" ]
          ++ map (
            m:
            "${
              if isNull m.name then m.input else "desc:${m.name}"
            }, ${toString m.resolution.x}x${toString m.resolution.y}@${toString m.refreshRate}, ${
              if isNull m.position then "auto" else "${toString m.position.x}x${toString m.position.y}"
            }, ${if isNull m.scale then "auto" else toString m.scale}"
          ) hardware.monitors;

        workspace =
          lib.optional (!isNull hardware.primaryMonitor)
            "1, monitor:${
              if isNull hardware.primaryMonitor.name then
                hardware.primaryMonitor.input
              else
                "desc:${hardware.primaryMonitor.name}"
            }";

        cursor = {
          use_cpu_buffer = cfg.hw-cursor-cpu-buffer;
          inactive_timeout = 6;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        general = {
          gaps_in = "4";
          gaps_out = "8";

          border_size = "2";

          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = "6";

          active_opacity = "1.0";
          inactive_opacity = "1.0";

          shadow = {
            enabled = true;
            range = "4";
            render_power = "3";
          };

          blur = {
            enabled = true;
            size = "3";
            passes = "1";

            vibrancy = "0.1696";
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "overshootBezier, 0.05, 0.9, 0.2, 1.02"
            "stableBezier, 0.05, 0.9, 0.2, 1.0"
          ];

          animation = [
            "windows, 1, 4, overshootBezier"
            "border, 1, 10, overshootBezier"
            "borderangle, 1, 8, overshootBezier"
            "fade, 1, 4, stableBezier"
            "workspaces, 1, 6, overshootBezier"
          ];
        };

        dwindle = {
          pseudotile = false;
          preserve_split = false;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = "-1";
          disable_hyprland_logo = true;
          vfr = true;
        };

        input = {
          kb_layout = "us";
          follow_mouse = "1";

          accel_profile = cfg.acceleration-profile;
          sensitivity = cfg.sensitivity;

          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = false;
        };

        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod, F, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, D, exec, $menu"
          "$mainMod CONTROL, L, exec, $lock"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, h, movefocus, l"
          "$mainMod, j, movefocus, d"
          "$mainMod, k, movefocus, u"
          "$mainMod, l, movefocus, r"

          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, j, movewindow, d"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, l, movewindow, r"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        windowrulev2 = "suppressevent maximize, class:.*";
      };
    };
  };
}
