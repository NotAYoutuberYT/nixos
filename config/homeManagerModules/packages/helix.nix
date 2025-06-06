{ lib, config, ... }:

{
  options.specialConfig.helix.enable = lib.mkEnableOption "helix";

  config = lib.mkIf config.specialConfig.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "base16_default";

        editor = {
          cursorline = true;
          line-number = "relative";
          true-color = true;

          rulers = [ 120 ];

          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
            other-lines = "disable";
          };

          statusline = {
            left = [
              "mode"
              "spinner"
              "version-control"
              "file-name"
            ];
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };

        keys.normal = {
          A-x = "extend_to_line_bounds";
          X = "select_line_above";
        };

        keys.select = {
          A-x = "extend_to_line_bounds";
          X = "select_line_above";
        };
      };
    };
  };
}
