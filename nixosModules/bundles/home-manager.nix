{ lib, config, inputs, outputs, customLib, pkgs, ... }:

let
  cfg = config.nixosConfig;
in {
  options.nixosConfig = {
    userName = lib.mkOption {
      default = "bryce";
      description = ''
        username
      '';
    };

    userConfig = lib.mkOption {
      type = lib.types.str;
      description = ''
        home-manager config path
      '';
    };

    userNixosSettings = lib.mkOption {
      default = {};
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

      users = {
        ${cfg.userName} = {...}: {
          imports = [
            (import cfg.userConfig)
            outputs.homeManagerModules.default
          ];
        };
      };
    };

    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = cfg.userName;
      extraGroups = [ "networkmanager" "storage" "wheel" ];
    }
    // cfg.userNixosSettings;
  };
}
