{ lib, ... }:

{
  options.specialConfig.desktopHardware = {
    monitors = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              example = "DP-1";
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
        }
      );

      default = [ ];
    };
  };
}
