{ pkgs, lib, ... }:

{
  options.specialConfig.sops.enablePackage = lib.mkEnableOption "sops package";

  config = {
    environment.systemPackages = [ pkgs.sops ];

    sops = {
      defaultSopsFile = ../secrets/primary.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/var/lib/sops-nix/key.txt";

      secrets.hashed-password.neededForUsers = true;
      secrets.vaultwarden-admin-token.sopsFile = ../secrets/services/vaultwarden.yaml;
      secrets.karakeep-secret.sopsFile = ../secrets/services/karakeep.yaml;
      secrets.vikunja-jwt-secret.sopsFile = ../secrets/services/vikunja.yaml;

      secrets.cloudflare-dns-edit-key = {
        mode = "0444"; # TODO: fix this!!
        sopsFile = ../secrets/api_keys.yaml;
      };
    };
  };
}
