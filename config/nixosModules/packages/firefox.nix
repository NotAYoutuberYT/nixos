{ lib, config, ... }:

{
  options.specialConfig.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf config.specialConfig.firefox.enable {
    programs.firefox.enable = true;
  };
}
