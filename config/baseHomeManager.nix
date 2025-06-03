{
  inputs,
  lib,
  config,
  osConfig,
  ...
}:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  options.specialConfig = {
    colorScheme = lib.mkOption {
      default = inputs.nix-colors.colorSchemes.default-dark;

      description = ''
        base16 color scheme to be used in program configs.
        options can be found at https://tinted-theming.github.io/tinted-gallery/
      '';
    };

    homeDirectory = lib.mkOption {
      default = /home/${osConfig.specialConfig.username};
      type = lib.types.path;
      description = ''
        home directory for user
      '';
    };
  };

  config = {
    home.username = osConfig.specialConfig.username;
    home.homeDirectory = lib.mkForce config.specialConfig.homeDirectory;

    colorScheme = config.specialConfig.colorScheme;

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
  };
}
