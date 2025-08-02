{ pkgs, lib, config, ... }:

let
  cfg = config.specialConfig.nebula;
in
{
  options.specialConfig.nebula = {
    enable = lib.mkEnableOption "nebula";

    staticLighthouseMaps = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = { "10.0.0.1" = [ "194.13.80.114:4242" ]; };
    };

    allowedGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "equi" ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nebula ];

    services.nebula.networks.mesh = {
      enable = true;

      ca = "/etc/nebula/ca.crt";
      cert = "/etc/nebula/host.crt";
      key = "/etc/nebula/host.key";

      firewall.outbound = [
        {
          host = "any";
          port = "any";
          proto = "any";
        }
      ];

      firewall.inbound = [
        {
          groups = cfg.allowedGroups;
          port = "any";
          proto = "any";
        }
      ];

      isLighthouse = false;

      staticHostMap = cfg.staticLighthouseMaps;

      lighthouses = builtins.attrNames cfg.staticLighthouseMaps;
    };
  };
}
