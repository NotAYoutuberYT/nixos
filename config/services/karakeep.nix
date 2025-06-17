{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.specialConfig.services.karakeep;
  currentDevice = config.specialConfig.hosting.device;

  isHosting = currentDevice == cfg.hostingDevice;
  isProxying = (currentDevice == cfg.proxyingDevice) && !(builtins.isNull cfg.hostingDevice);
in
{
  options.specialConfig.services.karakeep = {
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
      default = "karakeep.${config.specialConfig.hosting.baseDomain}";
      description = "the domain of the service";
      example = "service.example.xyz";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3002;
      description = "the port the service should bind to";
    };

    browserPort = lib.mkOption {
      type = lib.types.port;
      default = 4002;
      description = "the port the browser service should bind to";
    };
  };

  config = {
    services.karakeep = lib.mkIf isHosting {
      enable = true;
      meilisearch.enable = true;

      browser.enable = true;
      browser.exe = lib.getExe pkgs.ungoogled-chromium;
      browser.port = cfg.browserPort;

      environmentFile = config.sops.secrets.karakeep-secret.path;
      extraEnvironment = {
        NEXTAUTH_URL = cfg.domain;
        PORT = toString cfg.port;

        DISABLE_SIGNUPS = "true";
        DISABLE_NEW_RELEASE_CHECK = "true";
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
