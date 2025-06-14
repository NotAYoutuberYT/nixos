{ lib, config, ... }:

{
  options.specialConfig.services.cloudflare-dyndns.enable = lib.mkEnableOption "cloudflare-dyndns";

  config.services.cloudflare-dyndns =
    lib.mkIf config.specialConfig.services.cloudflare-dyndns.enable
      {
        enable = true;
        apiTokenFile = config.sops.secrets.cloudflare-dns-edit-key.path;
        proxied = true;
        domains = [ config.specialConfig.hosting.baseDomain ];
      };
}
