{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk.nix
  ];

  specialConfig = {
    hostHomeConfigModule = ./home.nix;

    bundles.command-line.enable = true;
    bundles.desktop.enable = true;
    stylix.enable = true;
  };

  specialConfig.services = {
    blocky.enable = true;
  };

  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  users.users.${config.specialConfig.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqkOs8CGx0oibgYIZ68QDp17xl97rnWlCPf7G8CZQwx equi@poco"
  ];

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  system.name = "poco";
  networking.hostName = "poco";
}
