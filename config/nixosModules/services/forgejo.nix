{ lib, config, ... }:

let
  srv = config.services.forgejo.settings.server;
in
{
  options.specialConfig.services.forgejo.enable = lib.mkEnableOption "forgejo";

  config = lib.mkIf config.specialConfig.services.forgejo.enable {
    services.forgejo = {
      enable = true;
      stateDir = "/var/lib/forgejo";

      database.type = "postgres";

      dump.enable = true;

      settings = {
        server.DOMAIN = "forgejo.bryceh.com";
        server.ROOT_URL = "https://${srv.DOMAIN}";
        server.HTTP_PORT = 3000;
        server.DISABLE_SSH = true;

        # I *could* declaritively manage the admin user, but it's easier and less
        # janky to just make this false for 10 seconds on a new deployment.
        service.DISABLE_REGISTRATION = true;

        session.COOKIE_SECURE = true;

        DEFAULT.APP_NAME = "Forgejo";
        DEFAULT.APP_SLOGAN = "Hosted at ${srv.DOMAIN}.";
      };
    };

    networking.firewall.allowedUDPPorts = [ ];
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    # TODO: fix acme and improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."${srv.DOMAIN}" = {
        enableACME = true;
        forceSSL = true;
        extraConfig = ''
          client_max_body_size 512M;
        '';

        locations."/".proxyPass = "http://127.0.0.1:${toString srv.HTTP_PORT}";
      };
    };
  };
}
