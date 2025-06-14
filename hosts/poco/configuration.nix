{ config, ... }:

let
  device = config.specialConfig.hosting.device;
in
{
  imports = [
    ./hardware-configuration.nix
    ./disk.nix
  ];

  specialConfig.services = {
    blocky.enable = true;

    forgejo.hostingDevice = device;
    forgejo.proxyingDevice = device;

    vaultwarden.hostingDevice = device;
    vaultwarden.proxyingDevice = device;

    cloudflare-dyndns.enable = true;
  };
}
