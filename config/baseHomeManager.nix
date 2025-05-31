{
  inputs,
  config,
  osConfig,
  lib,
  customLib,
  ...
}:

let
  cfg = config.specialConfig;
  ocfg = osConfig.specialConfig;

  modules = customLib.allModules ./homeManagerModules;
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ] ++ modules;

  options.specialConfig = {
    colorScheme = lib.mkOption {
      default = inputs.nix-colors.colorSchemes.default-dark;

      description = ''
        base16 color scheme to be used in program configs.
        options can be found at https://tinted-theming.github.io/tinted-gallery/
      '';
    };

    homeDirectory = lib.mkOption {
      default = /home/${ocfg.username};
      type = lib.types.path;
      description = ''
        home directory for user
      '';
    };
  };

  config = {
    home.username = ocfg.username;
    home.homeDirectory = lib.mkForce cfg.homeDirectory;

    colorScheme = cfg.colorScheme;

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
  };
}
