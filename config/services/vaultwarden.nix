{ lib, config, ... }:

let
  cfg = config.specialConfig.services.vaultwarden;
  currentDevice = config.specialConfig.hosting.device;

  isHosting = currentDevice == cfg.hostingDevice;
  isProxying = (currentDevice == cfg.proxyingDevice) && !(builtins.isNull cfg.hostingDevice);
in
{
  options.specialConfig.services.vaultwarden = {
    hostingDevice = lib.mkOption {
      type = lib.types.nullOr lib.types.server;
      default = null;
      description = "the device hosting the service";
    };

    proxyingDevice = lib.mkOption {
      type = lib.types.nullOr lib.types.server;
      default = null;
      description = "the device proxying the service";
    };

    domain = lib.mkOption {
      type = lib.types.str;
      default = "vaultwarden.${config.specialConfig.hosting.baseDomain}";
      description = "the domain of the service";
      example = "service.example.xyz";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8122;
      description = "the port the service should bind to";
    };
  };

  config = {
    services.vaultwarden = lib.mkIf isHosting {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/backup/vaultwarden";

      environmentFile = config.sops.secrets.vaultwarden-admin-token.path;

      config = {
        ROCKET_PORT = cfg.port;
        ROCKET_ADDRESS = "127.0.0.1";

        DOMAIN = "https://${cfg.domain}";

        SIGNUPS_ALLOWED = false;
        INVITATIONS_ALLOWED = false;
        SHOW_PASSWORD_HINT = false;
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf isProxying [
      80
      443
    ];

    specialConfig.services.acme.enable = lib.mkIf isProxying true;
    services.nginx = lib.mkIf isProxying {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."${cfg.domain}" = {
        forceSSL = true;
        enableACME = true;

        locations."/".proxyPass = "http://${
          if isHosting then "127.0.0.1" else cfg.hostingDevice.ip
        }:${toString cfg.port}";
      };
    };

    specialConfig.hosting.serviceDNSRecords = lib.optional (!builtins.isNull cfg.proxyingDevice) {
      domain = cfg.domain;
      record = cfg.proxyingDevice.ip;
    };
  };
}
