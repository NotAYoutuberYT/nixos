{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    homeConfigModule = ./home.nix;
  };

  system.name = "desktop";
  networking.hostName = "desktop";
}
