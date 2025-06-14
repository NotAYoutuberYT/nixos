{ lib, config, ... }:

{
  options.specialConfig.steam.enable = lib.mkEnableOption "steam";

  config = lib.mkIf config.specialConfig.steam.enable {
    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;

      gamescope.enable = true;
    };
  };
}
