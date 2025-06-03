{ lib, config, ... }:

{
  options.specialConfig.bundles.command-line.enable = lib.mkEnableOption "command-line bundle";

  config.specialConfig = lib.mkIf config.specialConfig.bundles.command-line.enable {
    git.enable = lib.mkDefault true;
    helix.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;

    zoxide.enable = lib.mkDefault true;
  };
}
