{
  lib,
  customLib,
}:
rec {
  # custom modules take in a base module (or a function which produces one) and a name and return
  # the custom module (which is itself a function of the module arguments, or margs, which include
  # pkgs, config, lib, and such).

  # only enables the config of a module if true is passed in
  enableIf =
    enable: module:
    let
      cleanedModule = customLib.cleanModule module;
      baseConfig = cleanedModule.config or { };
      withoutConfig = builtins.removeAttrs cleanedModule [ "config" ];
    in
    withoutConfig // { config = lib.mkIf enable baseConfig; };

  # adds an enable option to a module under config.nixosConfig
  withNixosEnableOption =
    { name, config }:
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = cleanedModule // {
        options.nixosConfig.${name}.enable = lib.mkEnableOption name;
      };
    in
    enableIf config.nixosConfig.${name}.enable withOption;

  # adds an enable option to a module under config.homeManagerConfig
  withHomeManagerEnableOption =
    { name, config }:
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = cleanedModule // {
        options.homeManagerConfig.${name}.enable = lib.mkEnableOption name;
      };
    in
    enableIf config.homeManagerConfig.${name}.enable withOption;

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
