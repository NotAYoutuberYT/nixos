{ lib, config, ... }:

{
  options.specialConfig.services.forgejo.enable = lib.mkEnableOption "forgejo";

  config = lib.mkIf config.specialConfig.services.forgejo.enable {
    services.forgejo = {
      enable = true;
      stateDir = "/var/lib/forgejo";

      database.type = "postgres";

      dump.enable = true;

      settings = {
        server.DOMAIN = "poco.bryceh.com";
        server.ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}";
        server.HTTP_PORT = 3000;

        session.COOKIE_SECURE = true;
      };
    };

    # TODO: fix acme and improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."poco.bryceh.com" = {
        enableACME = true;
        forceSSL = true;
        locations."/forgejo".proxyPass =
          "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
      };
    };
  };
}
