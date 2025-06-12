{ lib, config, ... }:

{
  options.specialConfig.services.vaultwarden.enable = lib.mkEnableOption "vaultwarden";

  config = lib.mkIf config.specialConfig.services.vaultwarden.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/backup/vaultwarden";

      environmentFile = config.sops.secrets.vaultwarden-admin-token.path;

      config = {
        ROCKET_PORT = 8122;
        ROCKET_ADDRESS = "127.0.0.1";

        DOMAIN = "https://vaultwarden.bryceh.com";

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

    # TODO: improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."vaultwarden.bryceh.com" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          # proxyWebsockets = true;
        };
      };
    };
  };
}
