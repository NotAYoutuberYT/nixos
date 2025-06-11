{ lib, config, ... }:

{
  options.specialConfig.services.vaultwarden.enable = lib.mkEnableOption "vaultwarden";

  config.services.vaultwarden = lib.mkIf config.specialConfig.services.vaultwarden.enable {
    enable = true;
    dbBackend = "sqlite";
    backupDir = "/var/backup/vaultwarden";
  };
}
