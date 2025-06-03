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

    steam.enable = true;
  };

  system.name = "envy";
  networking.hostName = "envy";
}
