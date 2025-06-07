{ lib, config, ... }:

{
  options.specialConfig.kitty.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf config.specialConfig.kitty.enable {
    programs.kitty = {
      enable = true;

      extraConfig = builtins.concatStringsSep "\n" [
        "confirm_os_window_close 0"
      ];
    };
  };
}
