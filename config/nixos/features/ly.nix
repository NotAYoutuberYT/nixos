{ lib, config, ... }:

{
  options.specialConfig.ly.enable = lib.mkEnableOption "ly";

  config = lib.mkIf config.specialConfig.ly.enable {
    services.displayManager.ly.enable = true;
  };
}
