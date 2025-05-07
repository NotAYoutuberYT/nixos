{ lib, customLib }:

rec {
  # only enables the config of a module if true is passed in
  enableIf =
    enable: module:
    let
      cleanedModule = customLib.cleanModule module;
      baseConfig = cleanedModule.config or { };
      withoutConfig = builtins.removeAttrs cleanedModule [ "config" ];
    in
    withoutConfig // { config = lib.mkIf enable baseConfig; };

  # adds an enable option to a module under config.nixosConfig. the enable option
  # defaults to the value of enable (or false if not present)
  withNixosEnableOption =
    {
      name,
      config,
      enable ? false,
    }:
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = lib.recursiveUpdate cleanedModule {
        options.nixosConfig.${name}.enable = lib.mkOption {
          default = enable;
          example = !enable;
          description = "Whether to enable ${name}.";
          type = lib.types.bool;
        };
      };
    in
    enableIf config.nixosConfig.${name}.enable withOption;

  # adds an enable option to a module under config.homeManagerConfig. the enable option
  # defaults to the value of enable (or false if not present)
  withHomeManagerEnableOption =
    {
      name,
      config,
      enable ? false,
    }:
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = lib.recursiveUpdate cleanedModule {
        options.homeManagerConfig.${name}.enable = lib.mkOption {
          default = enable;
          example = !enable;
          description = "Whether to enable ${name}.";
          type = lib.types.bool;
        };
      };
    in
    enableIf config.homeManagerConfig.${name}.enable withOption;

  # enables a home manager module only if a corresponding module is enabled in nixos
  ifEnabledInNixos =
    { name, osConfig }: module: enableIf (osConfig.nixosConfig.${name}.enable or false) module;

  # adds an enable option under config.nixosConfig.bundles
  nixosBundle =
    { name, config }:
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = lib.recursiveUpdate cleanedModule {
        options.nixosConfig.bundles.${name}.enable = lib.mkEnableOption name;
      };
    in
    enableIf config.nixosConfig.bundles.${name}.enable withOption;

  # adds an enable option under config.homeManagerConfig.bundles
  homeManagerBundle =
    { name, config }:
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = lib.recursiveUpdate cleanedModule {
        options.homeManagerConfig.bundles.${name}.enable = lib.mkEnableOption name;
      };
    in
    enableIf config.homeManagerConfig.bundles.${name}.enable withOption;

  # creates options to toggle each package on and off
  optionalPackages =
    { config }:
    packages:
    let
      optionsList = map (
        package:
        let
          packageName = customLib.packageName package;
        in
        {
          name = packageName;
          value.enable = lib.mkEnableOption packageName;
        }
      ) packages;
    in
    {
      options.nixosConfig = builtins.listToAttrs optionsList;
      config.environment.systemPackages = builtins.filter (
        package: config.nixosConfig.${customLib.packageName package}.enable
      ) packages;
    };
}
