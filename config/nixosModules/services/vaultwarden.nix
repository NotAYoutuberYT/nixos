{ lib, config, ... }:

{
  options.specialConfig.services.vaultwarden.enable = lib.mkEnableOption "vaultwarden";

  config = lib.mkIf config.specialConfig.services.vaultwarden.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/backup/vaultwarden";

      config = {
        ROCKET_PORT = 3000;

        WEB_VAULT_ENABLED = true;
        SIGNUPS_ALLOWED = false;
        INVITATIONS_ALLOWED = false;

        SHOW_PASSWORD_HINT = false;
      };
    };

    # TODO: improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx.virtualHosts."bitwarden.bryceh.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      };
    };
  };
}
