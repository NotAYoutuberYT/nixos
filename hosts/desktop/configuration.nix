{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  specialConfig = {
    hostHomeConfigModule = ./home.nix;

    bundles.desktop.enable = true;
    bundles.command-line.enable = true;
    stylix.enable = true;

    nvidia.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.name = "desktop";
  networking.hostName = "desktop";
}
