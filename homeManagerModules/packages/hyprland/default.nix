{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

let
  cfg = config.homeManagerConfig.hyprland;

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

    sleep 0.5

    wallpapers=("${./wallpapers}"/*)
    wallpaperIndex=$(( RANDOM % ''${''\#wallpapers[@]} ))
    selectedWallpaper="''${wallpapers[$wallpaperIndex]}"

    ${pkgs.swww}/bin/swww img --transition-type none "$selectedWallpaper"
  '';
in
{
  options.homeManagerConfig.hyprland = {
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
  };

  imports = [
    ./hyprlock.nix
  ];

  config = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$terminal" = "alacritty";
        "$fileManager" = "thunar";
        "$menu" = "rofi -show drun -show-icons";
        "$lock" = "hyprlock";

        monitor = cfg.monitors;
        workspace = cfg.workspaces;
        exec-once = "${startupScript}/bin/start";

        general = {
          gaps_in = "4";
          gaps_out = "16";

          border_size = "2";

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = "false";

          allow_tearing = "false";

          layout = "dwindle";
        };

        decoration = {
          rounding = "6";

          active_opacity = "1.0";
          inactive_opacity = "0.9";

          drop_shadow = "true";
          shadow_range = "4";
          shadow_render_power = "3";
          "col.shadow" = "rgba(1a1a1aee)";

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
          pseudotile = "true";
          preserve_split = "true";
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = "-1";
          disable_hyprland_logo = "true";
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
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, D, exec, $menu"
          "$mainMod, L, exec, $lock"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, h, movefocus, l"
          "$mainMod, j, movefocus, d"
          "$mainMod, k, movefocus, u"
          "$mainMod, l, movefocus, r"

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

        windowrulev2 = "suppressevent maximize, class:.*"; # You'll probably like this.
      };
    };
  };
}
