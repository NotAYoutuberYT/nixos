{ name, ... }:
{ lib, pkgs, ... }:

{
  options.nixosConfig.${name}.enablePackage = lib.mkEnableOption "sops package";

  config = {
    environment.systemPackages = [ pkgs.sops ];

    sops = {
      defaultSopsFile = ../../../secrets/primary.yaml;
      age.keyFile = "/var/lib/sops-nix/key.txt";

      secrets.hashed-password.neededForUsers = true;
    };
  };
}
