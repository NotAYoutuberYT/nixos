{ lib, ... }:

{
  options.specialConfig.steam.enable = lib.mkEnableOption "steam";

  config = {
    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;

      gamescope.enable = true;
    };
  };
}
