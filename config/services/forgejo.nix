{ lib, config, ... }:

let
  cfg = config.specialConfig.services.forgejo;
  currentDevice = config.specialConfig.hosting.device;

  isHosting = currentDevice == cfg.hostingDevice;
  isProxying = (currentDevice == cfg.proxyingDevice) && !(builtins.isNull cfg.hostingDevice);
in
{
  options.specialConfig.services.forgejo = {
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
      default = "forgejo.${config.specialConfig.hosting.baseDomain}";
      description = "the domain of the service";
      example = "service.example.xyz";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "the port the service should bind to";
    };
  };

  config = {
    services.forgejo = lib.mkIf isHosting {
      enable = true;
      stateDir = "/var/lib/forgejo";
      database.type = "postgres";
      dump.enable = true;

      settings = {
        server.DOMAIN = cfg.domain;
        server.ROOT_URL = "https://${cfg.domain}";
        server.HTTP_PORT = cfg.port;
        server.DISABLE_SSH = true;

        # I could probably declaritively manage users, but it's easier and less
        # janky to just make this false for 10 seconds on a new deployment.
        service.DISABLE_REGISTRATION = true;

        session.COOKIE_SECURE = true;

        other.SHOW_FOOTER_VERSION = false;

        DEFAULT.APP_NAME = "Forgejo";
        DEFAULT.APP_SLOGAN = "A self-hosted instance";
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
        forceSSL = true;
        extraConfig = ''
          client_max_body_size 512M;
        '';

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
