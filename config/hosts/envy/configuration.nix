{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    homeConfigModule = ./home.nix;
  };

  system.name = "envy";
  networking.hostName = "envy";
}
