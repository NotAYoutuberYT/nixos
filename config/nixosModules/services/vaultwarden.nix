{ lib, config, ... }:

{
  options.specialConfig.services.vaultwarden.enable = lib.mkEnableOption "vaultwarden";

  config = lib.mkIf config.specialConfig.services.vaultwarden.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/backup/vaultwarden";

      config = {
        ROCKET_PORT = 8222;
        ROCKET_ADDRESS = "127.0.0.1";

        DOMAIN = "https://poco.bryceh.com";

        SIGNUPS_ALLOWED = false;
        INVITATIONS_ALLOWED = false;
        SHOW_PASSWORD_HINT = false;

        LOG_FILE = "/var/lib/log/vaultwarden/vaultwarden.log";
      };
    };

    networking.firewall.allowedUDPPorts = [ ];
    networking.firewall.allowedTCPPorts = [ 443 ];

    # TODO: fix acme and improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx =
      let
        host = "poco.bryceh.com";
      in
      {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts."${host}" = {
          forceSSL = true;
          enableACME = true;
          extraConfig = ''
            access_log /var/log/nginx/${host}.access.log;
            error_log /var/log/nginx/${host}.error.log;
          '';

          locations."/vaultwarden" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
            proxyWebsockets = true;
          };
        };
      };
  };
}
