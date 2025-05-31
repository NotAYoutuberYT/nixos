{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  specialConfig = {
    homeConfigModule = ./home.nix;

    bundles.desktop.enable = true;
    bundles.command-line.enable = true;
    nvidia.enable = true;
  };

  system.name = "desktop";
  networking.hostName = "desktop";
}
