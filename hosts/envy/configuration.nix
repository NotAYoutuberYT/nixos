{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  specialConfig = {
    hostHomeConfigModule = ./home.nix;

    bundles.command-line.enable = true;
    bundles.desktop.enable = true;
    network-manager.enable = true;
    stylix.enable = true;

    steam.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.powertop.enable = true;

  system.name = "envy";
  networking.hostName = "envy";
}
