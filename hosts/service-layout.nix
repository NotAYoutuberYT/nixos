{ lib, config, ... }:

let
  getDevice = lib.devices.getDevice config.specialConfig.hosting.devices;
in
{
  config.specialConfig.services = {
    forgejo.hostingDevice = getDevice "poco";
    forgejo.proxyingDevice = getDevice "poco";

    vaultwarden.hostingDevice = getDevice "poco";
    vaultwarden.proxyingDevice = getDevice "poco";

    blocky.hostingDevices = [ (getDevice "poco") ];

    cloudflare-dyndns.hostingDevices = [ (getDevice "poco") ];
  };
}
