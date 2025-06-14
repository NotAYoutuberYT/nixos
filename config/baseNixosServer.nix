{
  inputs,
  lib,
  config,
  ...
}:

let
  serviceModules = lib.allModules ./services;
in
{
  imports = [
    inputs.lix-module.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.nur.modules.nixos.default
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
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
  };

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.overlays = [
      (final: super: {
        nginxStable = super.nginxStable.override { openssl = super.pkgs.libressl; };
      })
    ];

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";

    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
      };
    };

    users.users.root.openssh.authorizedKeys.keys = [
      config.specialConfig.hosting.device.sshPublicKey
    ];

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    system.name = config.specialConfig.hosting.device.name;
    networking.hostName = config.specialConfig.hosting.device.name;
  };
}
