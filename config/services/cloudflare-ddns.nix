{ lib, config, ... }:

let
  cfg = config.specialConfig.services.cloudflare-dyndns;
  currentDevice = config.specialConfig.hosting.device;

  isHosting = builtins.elem currentDevice cfg.hostingDevices;
in
{
  options.specialConfig.services.cloudflare-dyndns.hostingDevices = lib.mkOption {
    type = lib.types.listOf lib.types.server;
    default = [ ];
    description = "the devices hosting the service";
  };

  config.services.cloudflare-dyndns = lib.mkIf isHosting {
    enable = true;
    proxied = true;
    domains = [ config.specialConfig.hosting.baseDomain ];
    apiTokenFile = config.sops.secrets.cloudflare-dns-edit-key.path;
  };
}
