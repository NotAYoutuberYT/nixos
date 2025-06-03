{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.specialConfig = {
    username = lib.mkOption {
      default = "equi";
      type = lib.types.str;
      description = "system-wide username";
    };

    hostHomeConfigModule = lib.mkOption {
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
    users.mutableUsers = false;
    users.users.${config.specialConfig.username} =
      {
        isNormalUser = true;
        shell = config.specialConfig.shell;
        description = config.specialConfig.username;
        extraGroups = [
          "wheel"
        ];
      }
      // config.specialConfig.passwordAttrset
      // config.specialConfig.extraSettings;
  };
}
