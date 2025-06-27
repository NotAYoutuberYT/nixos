{ lib, config, ... }:

let
  cfg = config.specialConfig.desktopHardware;

  monitor = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "Monitor Company LDHDTYGN";
      };
      
      input = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "DP-1";
      };

      primary = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "if this is the primary monitor";
      };

      resolution = lib.mkOption {
        type = lib.types.submodule {
          options = {
            x = lib.mkOption {
              type = lib.types.ints.unsigned;
              example = 1920;
            };

            y = lib.mkOption {
              type = lib.types.ints.unsigned;
              example = 1080;
            };
          };
        };
      };

      refreshRate = lib.mkOption {
        type = lib.types.ints.unsigned;
        example = 60;
      };

      position = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.submodule {
            options = {
              x = lib.mkOption {
                type = lib.types.ints.unsigned;
                example = 1920;
              };

              y = lib.mkOption {
                type = lib.types.ints.unsigned;
                example = 0;
              };
            };
          }
        );
        default = null;
        description = "the position of the top-left corner of the monitor. +x is to the right, +y is down. a value of null will let the compositor decide automatically.";
      };

      scale = lib.mkOption {
        type = lib.types.nullOr (lib.types.numbers.between 0.0 5.0);
        default = null;
        description = "the monitor's scale. a value of null will let the compositor decide automatically.";
      };
    };
  };
in
{
  options.specialConfig.desktopHardware = {
    monitors = lib.mkOption {
      type = lib.types.listOf monitor;
      default = [ ];
    };

    primaryMonitor = lib.mkOption {
      type = lib.types.nullOr monitor;
      default = lib.findFirst (m: m.primary) null cfg.monitors;
      description = "the primary monitor";
    };
  };
}
