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
    vaultwarden.enable = true;
  };

  services.openssh.enable = true;
  users.users.${config.specialConfig.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHIwz65TGcGvqNSaFeEVwhlU4tgerIzSKowMohncTLUg equi@poco"
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  system.name = "poco";
  networking.hostName = "poco";
}
