{ lib, config, ... }:

{
  options.specialConfig.services.acme.enable = lib.mkEnableOption "acme";

  config.security.acme = lib.mkIf config.specialConfig.services.acme.enable {
    acceptTerms = true;
    defaults.email = "utbryceh@gmail.com";
    maxConcurrentRenewals = 3;
  };
}
