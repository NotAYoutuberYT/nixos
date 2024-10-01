{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    bundles.system.enable = true;
    bundles.desktop.enable = true;
    bundles.home-manager.enable = true;
    nvidia.enable = true;

    piper.enable = true;
  };

  boot.loader.grub.useOSProber = true;

  system.name = "desktop-nixos";

  nixosConfig.homeConfigModule = ./home.nix;
}
