{ lib, config, ... }:

{
  options.specialConfig.services.forgejo.enable = lib.mkEnableOption "forgejo";

  config = lib.mkIf config.specialConfig.services.forgejo.enable {
    services.forgejo = {
      enable = true;
      stateDir = "/var/lib/forgejo";

      dump.enable = true;

      settings = {
        session.COOKIE_SECURE = true;
        server.PROTOCOL = "https";
        server.HTTP_PORT = 3001;
        server.DISABLE_SSH = true;
        log.LEVEL = "Warn";
      };
    };

    # TODO: improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx.virtualHosts."forgejo.bryceh.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.HTTP_PORT}";
      };
    };
  };
}
