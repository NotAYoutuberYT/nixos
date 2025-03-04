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
      default = "equi";
      type = lib.types.str;
      description = ''
        username
      '';
    };

    homeDirectory = lib.mkOption {
      default = /home/${cfg.username};
      type = lib.types.path;
      description = ''
        username
      '';
    };

    shell = lib.mkOption {
      default = pkgs.bash;
      type = lib.types.package;
      description = ''
        user's default shell
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
      shell = cfg.shell;
      description = cfg.username;
      extraGroups = [
        "networkmanager"
        "storage"
        "wheel"
      ];
    } // cfg.userNixosSettings;
  };
}
