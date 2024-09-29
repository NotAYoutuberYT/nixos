{
  pkgs,
  system,
  inputs,
  config,
  lib,
  customLib,
  ...
}:

let
  cfg = config.nixosConfig;

  features = customLib.extendModules (name: {
    extraOptions = {
      nixosConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (customLib.filesIn ./features);

  packages = customLib.extendModules (name: {
    extraOptions = {
      nixosConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (customLib.filesIn ./packages);

  desktop = customLib.extendModules (name: {
    extraOptions = {
      nixosConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (customLib.filesIn ./desktop);

  bundles = customLib.extendModules (name: {
    extraOptions = {
      nixosConfig.bundles.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (customLib.filesIn ./bundles);
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ] ++ features ++ packages ++ desktop ++ bundles;

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.05";
  };
}
