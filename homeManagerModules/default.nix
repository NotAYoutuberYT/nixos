{ pkgs, system, inputs, config, lib, customLib, ... }:

let
  cfg = config.homeManagerConfig;

  packages =
    customLib.extendModules
    (name: {
      extraOptions = {
        homeManagerConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (customLib.filesIn ./packages);

  bundles =
    customLib.extendModules
    (name: {
      extraOptions = {
        homeManagerConfig.bundles.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (customLib.filesIn ./bundles);
in {
  imports =
    []
    ++ packages
    ++ bundles;
}