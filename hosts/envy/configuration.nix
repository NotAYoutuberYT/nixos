{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    bundles.system.enable = true;
    bundles.desktop.enable = true;
    bundles.home-manager.enable = true;
    networking = {
      enable = true;
      gui = true;
    };
  };

  system.name = "envy-nixos";

  nixosConfig.homeConfigModule = ./home.nix;
}
