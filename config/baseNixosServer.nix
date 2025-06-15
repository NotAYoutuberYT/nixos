{
  inputs,
  lib,
  config,
  modulesPath,
  ...
}:

let
  serviceModules = lib.allModules ./services;
in
{
  imports = [
    inputs.nur.modules.nixos.default
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
    "${modulesPath}/profiles/hardened.nix"
    ./sops.nix
  ] ++ serviceModules;

  options.specialConfig.hosting = {
    devices = lib.mkOption {
      type = lib.types.listOf lib.types.server;
      description = "the devices hosting services";
    };

    device = lib.mkOption {
      type = lib.types.addCheck lib.types.server (
        d: lib.throwIfNot (builtins.elem d config.specialConfig.hosting.devices)
      );

      description = "the current device being configured";
    };

    baseDomain = lib.mkOption {
      type = lib.types.str;
      default = "bryceh.com";
      description = "the base domain which resolves to (perhaps a proxy of) the hosted services";
    };

    serviceDNSRecords = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            domain = lib.mkOption {
              type = lib.types.str;
              description = "the domain to resolve";
              example = "service.example.xyz";
            };

            record = lib.mkOption {
              type = lib.types.str;
              description = "the ip to resolve";
              example = "192.168.1.300";
            };
          };
        }
      );
      default = [ ];
      description = "service DNS records to use on any NixOS-powered DNS servers";
    };
  };

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config.allowUnfree = false;
    system.stateVersion = "24.11";

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    system.name = config.specialConfig.hosting.device.name;
    networking.hostName = config.specialConfig.hosting.device.name;

    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
      persistent = true;
    };

    networking.firewall.enable = true;

    services.openssh = {
      enable = true;
      allowSFTP = false;

      extraConfig = ''
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
      '';

      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        X11Forwarding = false;
      };
    };

    users.users.root.openssh.authorizedKeys.keys = [
      config.specialConfig.hosting.device.sshPublicKey
    ];

    users.mutableUsers = false;
    nix.settings.allowed-users = [ "root" ];
    security.sudo.enable = false;
    environment.defaultPackages = lib.mkForce [ ];
  };
}
