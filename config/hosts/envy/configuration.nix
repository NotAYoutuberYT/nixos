{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    homeConfigModule = ./home.nix;

    bundles.command-line.enable = true;
    bundles.desktop.enable = true;
    network-manager.enable = true;

    steam.enable = true;
  };

  system.name = "envy";
  networking.hostName = "envy";
}
