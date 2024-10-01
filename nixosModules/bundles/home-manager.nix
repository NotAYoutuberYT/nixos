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
    homeConfigModule = lib.mkOption {
      type = lib.types.path;
      description = ''
        home module location  
      '';
    };

    username = lib.mkOption {
      default = "bryce";
      description = ''
        username
      '';
    };

    homeDirectory = lib.mkOption {
      default = /home/${cfg.username};
      description = ''
        username
      '';
    };

    userNixosSettings = lib.mkOption {
      default = { };
      description = ''
        NixOS user settings
      '';
    };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
        inherit customLib;
        outputs = inputs.self.outputs;
      };

      users.${cfg.username}.imports = [
        cfg.homeConfigModule
        outputs.homeManagerModules.default
      ];
    };

    users.users.${cfg.username} = {
      isNormalUser = true;
      description = cfg.username;
      extraGroups = [
        "networkmanager"
        "storage"
        "wheel"
      ];
    } // cfg.userNixosSettings;
  };
}
