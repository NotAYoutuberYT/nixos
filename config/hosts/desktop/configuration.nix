{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  system.name = "desktop";
  networking.hostName = "desktop";
}
