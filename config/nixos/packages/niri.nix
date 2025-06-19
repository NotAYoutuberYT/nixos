{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.specialConfig.niri;
in
{
  options.specialConfig.niri.enable = lib.mkEnableOption "niri";

  config = lib.mkIf cfg.enable {
    niri-flake.cache.enable = config.specialConfig.extraCaches;
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;
  };
}
