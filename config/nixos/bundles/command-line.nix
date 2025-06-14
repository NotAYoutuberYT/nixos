{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.specialConfig.bundles.command-line.enable = lib.mkEnableOption "command-line bundle";

  config = lib.mkIf config.specialConfig.bundles.command-line.enable {
    specialConfig.sops.enablePackage = lib.mkDefault true;

    environment.systemPackages = [
      pkgs.deploy-rs
      pkgs.corefonts
    ];
  };
}
