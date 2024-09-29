{ pkgs, config, ... }:

let
  mainWaybarConfig = {
    layer = "top";
    position = "top";

    modules-left = [
      "hyprland/workspaces"
    ];

    modules-center = [
      "clock"
    ];

    modules-right = [
      "battery"
    ];

    "hyprland/workspaces" = {
      disable-scroll = true;
      format = "{name}";
    };

    clock = {
      format = "{:%H:%M}";
      tooltip = false;
    };

    battery = {
      interval = 60;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      max-length = 25;
    };
  };

  css = ''
        * {
          font-size: 20px;
    	    font-family: monospace;
        }

        window#waybar {
    	    background: #292b2e;
    	    color: #fdf6e3;
        }

        #clock,
        #workspaces {
    	    background: #1a1a1a;
        }

        #clock,
        #battery,
        #workspaces button {
    	    padding: 0 2px;
    	    color: #e0e0e0;
        }

        #workspaces button.visible {
    	    background-color: #2783ab;
        }

        #workspaces button.active {
    	    background-color: #27ab51;
        }
  '';
in
{
  programs.waybar = {
    enable = true;
    style = css;
    settings = {
      mainBar = mainWaybarConfig;
    };
  };
}
