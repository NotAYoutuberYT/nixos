{ lib, customLib }:
{
  name,
  configNamespace,
  config,
  osConfig ? null,
}:

rec {
  enableIf =
    default: module:
    let
      cleanedModule = customLib.cleanModule module;
      baseConfig = cleanedModule.config or { };
      withoutConfig = builtins.removeAttrs cleanedModule [ "config" ];
      withOption = lib.recursiveUpdate {
        options.${configNamespace}.${name}.enable = lib.mkOption {
          inherit default;
          example = !default;
          description = "Whether to enable ${name}.";
          type = lib.types.bool;
        };
      } withoutConfig;
    in
    withOption // { config = lib.mkIf config.${configNamespace}.${name}.enable baseConfig; };

  withEnableOption = module: enableIf false module;

  ifEnabledInNixos = module: enableIf (osConfig.nixosConfig.${name}.enable) module;

  # adds an enable option under config.nixosConfig.bundles
  bundle =
    module:
    let
      cleanedModule = customLib.cleanModule module;
      withOption = lib.recursiveUpdate cleanedModule {
        options.${configNamespace}.bundles.${name}.enable = lib.mkEnableOption name;
      };
    in
    enableIf config.${configNamespace}.bundles.${name}.enable withOption;

  # creates options to toggle each package on and off
  optionalPackages =
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
