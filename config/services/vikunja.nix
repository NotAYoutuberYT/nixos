{ lib, config, ... }:

let
  cfg = config.specialConfig.services.vikunja;
  currentDevice = config.specialConfig.hosting.device;

  isHosting = currentDevice == cfg.hostingDevice;
  isProxying = (currentDevice == cfg.proxyingDevice) && !(builtins.isNull cfg.hostingDevice);
in
{
  options.specialConfig.services.vikunja = {
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
      default = "vikunja.${config.specialConfig.hosting.baseDomain}";
      description = "the domain of the service";
      example = "service.example.xyz";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3003;
      description = "the port the service should bind to";
    };
  };

  config = {
    services.vikunja = lib.mkIf isHosting {
      enable = true;

      port = cfg.port;
      frontendScheme = "https";
      frontendHostname = cfg.domain;

      environmentFiles = [ config.sops.secrets.vikunja-jwt-secret.path ];

      settings = {
        service.enableregistration = false;
        service.enableemailreminders = false;
        sentry.enabled = false;
        mailer.enabled = false;
        defaultsettings.week_start = 1;
        webhooks.enabled = false;
        autotls.enabled = false;
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
        enableACME = true;
        acmeRoot = null;
        forceSSL = true;

        locations."/".proxyPass = "http://${
          if isHosting then "127.0.0.1" else cfg.hostingDevice.ip
        }:${toString cfg.port}";
      };
    };

    specialConfig.services.acme.domains = [ cfg.domain ];

    specialConfig.hosting.serviceDNSRecords = lib.optional (!builtins.isNull cfg.proxyingDevice) {
      domain = cfg.domain;
      record = cfg.proxyingDevice.ip;
    };
  };
}
