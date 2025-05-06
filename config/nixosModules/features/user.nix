{ ... }:
{
  lib,
  config,
  inputs,
  outputs,
  customUtils,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig;
in
{
  options.nixosConfig = {
    username = lib.mkOption {
      default = "equi";
      type = lib.types.str;
      description = "system-wide username";
    };

    homeConfigModule = lib.mkOption {
      type = lib.types.path;
      description = ''
        home module location  
      '';
    };

    passwordAttrset = lib.mkOption {
      default = {
        hashedPasswordFile = config.sops.secrets.hashed-password.path;
      };
      description = "user password settings";
    };

    shell = lib.mkOption {
      default = pkgs.zsh;
      type = lib.types.package;
      description = ''
        user's default shell
      '';
    };

    extraSettings = lib.mkOption {
      default = { };
      description = ''
        extra user settings
      '';
    };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs customUtils;
        outputs = inputs.self.outputs;
      };

      users.${cfg.username}.imports = [
        cfg.homeConfigModule
        outputs.homeManagerModules.default
      ];
    };

    users.mutableUsers = false;
    users.users.${cfg.username} =
      {
        isNormalUser = true;
        shell = cfg.shell;
        description = cfg.username;
        extraGroups = [
          "wheel"
        ];
      }
      // cfg.passwordAttrset
      // cfg.extraSettings;
  };
}
