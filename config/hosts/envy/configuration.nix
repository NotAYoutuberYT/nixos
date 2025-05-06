{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  system.name = "envy";
  networking.hostName = "envy";
}
