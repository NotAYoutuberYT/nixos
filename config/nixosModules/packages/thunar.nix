{ lib, ... }:

{
  options.specialConfig.thunar.enable = lib.mkEnableOption "thunar";

  config = {
    programs.thunar.enable = true;
  };
}
