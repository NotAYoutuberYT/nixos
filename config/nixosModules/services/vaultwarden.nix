{ lib, config, ... }:

{
  options.specialConfig.services.vaultwarden.enable = lib.mkEnableOption "vaultwarden";

  config = lib.mkIf config.specialConfig.services.vaultwarden.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/backup/vaultwarden";

      config = {
        ROCKET_PORT = 8122;
        ROCKET_ADDRESS = "127.0.0.1";

        DOMAIN = "https://poco.bryceh.com/vaultwarden";

        SIGNUPS_ALLOWED = false;
        INVITATIONS_ALLOWED = false;
        SHOW_PASSWORD_HINT = false;
      };
    };

    networking.firewall.allowedUDPPorts = [ ];
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

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

          locations."/vaultwarden" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
            # proxyWebsockets = true;
          };
        };
      };
  };
}
