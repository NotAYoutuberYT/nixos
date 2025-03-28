{
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

  development = customLib.extendModules (name: {
    extraOptions = {
      nixosConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (customLib.filesIn ./development);

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
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.nur.modules.nixos.default
    ]
    ++ features
    ++ packages
    ++ development
    ++ desktop
    ++ bundles;

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    system.stateVersion = "24.05";
  };
}
