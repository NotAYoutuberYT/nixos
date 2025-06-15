{ lib, config, ... }:

{
  options.specialConfig.services.acme.enable = lib.mkEnableOption "acme";

  config = lib.mkIf config.specialConfig.services.acme.enable {
    users.users.nginx.extraGroups = [ "acme" ];

    security.acme = {
      acceptTerms = true;
      defaults.email = "utbryceh@gmail.com";

      certs."bryceh.com" =
        let
          env = builtins.toFile "acmeEnv" ''
            CLOUDFLARE_DNS_API_TOKEN_FILE=${config.sops.secrets.cloudflare-dns-edit-key.path}
          '';
        in
        {
          # server = "https://acme-staging-v02.api.letsencrypt.org/directory";
          webroot = null;
          extraDomainNames = [ "*.${config.specialConfig.hosting.baseDomain}" ];

          dnsProvider = "cloudflare";
          dnsPropagationCheck = true;
          environmentFile = env;
        };
    };
  };
}
