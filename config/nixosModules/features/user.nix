{ ... }:
{
  lib,
  config,
  inputs,
  outputs,
  customLib,
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
        hashedPassword = "$y$j9T$kL9VThKqR8iN8LZpb.8.m/$MD.2YUPUjdycoUKFQuJoqt1PjepZKcWjgi2HWr3HUs0";
        #hashedPasswordFile = config.sops.secrets.hashed-password.path;
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
        inherit inputs customLib;
        outputs = inputs.self.outputs;
      };

      users.${cfg.username}.imports = [
        #cfg.homeConfigModule
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
