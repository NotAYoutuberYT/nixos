{ lib, ... }:

{
  options.specialConfig.firefox.enable = lib.mkEnableOption "firefox";
  
  config = {
    programs.firefox.enable = true;
  };
}
