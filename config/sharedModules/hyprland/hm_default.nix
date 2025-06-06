{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

let
  cfg = config.specialConfig.hyprland;

  wallpaperInit = pkgs.pkgs.writeShellScriptBin "wallpaper" ''
    ${lib.getExe' pkgs.swww "swww-daemon"} &
    ${lib.getExe' pkgs.swww "swww"} img --transition-type none ${./wallpaper.png}
  '';

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${wallpaperInit}/bin/wallpaper
  '';

  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
in
{
  options.specialConfig.hyprland = {
    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ", preferred, auto, 1" ];
      description = "monitors for hyprland";
    };

    workspaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "hyprland workspaces";
    };

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

      settings = with config.colorScheme.palette; {
        "$terminal" = "${lib.getExe pkgs.alacritty}";
        "$fileManager" = "${lib.getExe pkgs.alacritty} --command ${lib.getExe pkgs.lf}";
        "$menu" = "${lib.getExe pkgs.rofi} -show drun -show-icons";
        "$lock" = "${lib.getExe pkgs.hyprlock}";

        monitor = cfg.monitors;
        workspace = cfg.workspaces;
        exec-once = [ "${lib.getExe startupScript}" ];

        cursor = {
          use_cpu_buffer = cfg.hw-cursor-cpu-buffer;
          inactive_timeout = 6;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        general = {
          gaps_in = "2";
          gaps_out = "4";

          border_size = "2";

          "col.active_border" = lib.concatStringsSep " " [
            (rgb base0D)
            (rgb base0E)
            "60deg"
          ];
          "col.inactive_border" = rgb base03;

          resize_on_border = "true";
          allow_tearing = "false";
          layout = "dwindle";
        };

        group = {
          "col.border_inactive" = rgb base03;
          "col.border_active" = rgb base0D;
          "col.border_locked_active" = rgb base0C;

          groupbar = {
            text_color = rgb base05;
            "col.active" = rgb base0D;
            "col.inactive" = rgb base03;
          };
        };

        decoration = {
          rounding = "6";

          active_opacity = "1.0";
          inactive_opacity = "1.0";

          shadow = {
            enabled = "true";
            range = "4";
            render_power = "3";
            color = rgba base00 "99";
          };

          blur = {
            enabled = "true";
            size = "3";
            passes = "1";

            vibrancy = "0.1696";
          };
        };

        animations = {
          enabled = "true";

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = "false";
          preserve_split = "false";
        };

        master = {
          new_status = "master";
        };

        misc = {
          background_color = rgb base00;
          force_default_wallpaper = "-1";
          disable_hyprland_logo = "true";
          vfr = "true";
        };

        input = {
          kb_layout = "us";
          follow_mouse = "1";

          accel_profile = cfg.acceleration-profile;
          sensitivity = cfg.sensitivity;

          touchpad = {
            natural_scroll = "true";
          };
        };

        gestures = {
          workspace_swipe = "false";
        };

        "$mainMod" = "ALT";

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
