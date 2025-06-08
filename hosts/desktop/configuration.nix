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

  system.name = "desktop";
  networking.hostName = "desktop";
}
