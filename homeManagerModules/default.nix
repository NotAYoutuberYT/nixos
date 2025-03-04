{
  pkgs,
  inputs,
  config,
  osConfig,
  lib,
  customLib,
  ...
}:

let
  cfg = config.homeManagerConfig;
  ocfg = osConfig.nixosConfig;

  packages = customLib.extendModules (name: {
    extraOptions = {
      homeManagerConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (customLib.filesIn ./packages);

  features = customLib.extendModules (name: {
    extraOptions = {
      homeManagerConfig.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (customLib.filesIn ./features);

  bundles = customLib.extendModules (name: {
    extraOptions = {
      homeManagerConfig.bundles.${name}.enable = lib.mkEnableOption "enable ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (customLib.filesIn ./bundles);
in
{
  imports =
    [
      inputs.nix-colors.homeManagerModules.default
      inputs.nur.modules.homeManager.default
    ]
    ++ packages
    ++ features
    ++ bundles;

  options.homeManagerConfig = {
    colorScheme = lib.mkOption {
      default = inputs.nix-colors.colorSchemes.default-dark;

      description = ''
        base16 color scheme to be used in program configs.
        options can be found at https://tinted-theming.github.io/tinted-gallery/
      '';
    };
  };

  config = {
    home.username = ocfg.username;
    home.homeDirectory = lib.mkForce ocfg.homeDirectory;

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";

    # essentially everything relies on nix-colors, so
    # it really makes sense to just set a scheme here
    colorScheme = cfg.colorScheme;
  };

  config.homeManagerConfig = {
    hyprland.enable = ocfg.hyprland.enable;
    waybar.enable = ocfg.hyprland.enable;

    zsh.enable = (ocfg.shell == pkgs.zsh);
  };
}
