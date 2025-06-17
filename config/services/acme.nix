{ lib, config, ... }:

{
  options.specialConfig.services.acme = {
    enable = lib.mkEnableOption "acme";
    domains = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf config.specialConfig.services.acme.enable {
    users.users.nginx.extraGroups = [ "acme" ];

    security.acme = {
      acceptTerms = true;
      defaults.email = "utbryceh@gmail.com";

      certs = builtins.listToAttrs (
        map (d: {
          name = d;
          value =
            let
              env = builtins.toFile "acmeEnv" ''
                CLOUDFLARE_DNS_API_TOKEN_FILE=${config.sops.secrets.cloudflare-dns-edit-key.path}
              '';
            in
            {
              # server = "https://acme-staging-v02.api.letsencrypt.org/directory";
              dnsProvider = "cloudflare";
              dnsPropagationCheck = true;
              environmentFile = env;
            };
        }) config.specialConfig.services.acme.domains
      );
    };
  };
}
