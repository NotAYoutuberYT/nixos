{ lib, config, ... }:

{
  options.specialConfig.thunar.enable = lib.mkEnableOption "thunar";

  config = lib.mkIf config.specialConfig.thunar.enable {
    programs.thunar.enable = true;
  };
}
