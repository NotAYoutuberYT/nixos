{ lib, config, ... }:

{
  options.specialConfig.services.blocky = {
    enable = lib.mkEnableOption "blocky";

    upstream-dns = lib.mkOption {
      default = [
        "tcp-tls:9.9.9.9"
        "tcp-tls:194.242.2.4"
      ];
    };
  };

  config = lib.mkIf config.specialConfig.services.blocky.enable {
    services.blocky = {
      enable = true;

      settings = {
        upstreams.groups.default = config.specialConfig.services.blocky.upstream-dns;

        ports.dns = 53;

        log.level = "warn";
        log.privacy = true;

        caching.minTime = "5m";
        caching.maxTime = "60m";

        # TODO: make this more modular
        customDNS.mapping =
          let
            deviceRecords = builtins.listToAttrs (
              map (d: {
                name = d.domain;
                value = d.ip;
              }) config.specialConfig.hosting.devices
            );
          in
          {
            "poco.bryceh.com" = "192.168.1.11";
            "forgejo.bryceh.com" = "192.168.1.11";
            "vaultwarden.bryceh.com" = "192.168.1.11";
          }
          // deviceRecords;

        blocking.denylists = {
          default = [
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/pro.txt"
            "https://big.oisd.nl/domainswild"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://v.firebog.net/hosts/AdguardDNS.txt"
            "https://v.firebog.net/hosts/Admiral.txt"
            "https://v.firebog.net/hosts/Easylist.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/popupads.txt"
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/Easyprivacy.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/native.huawei.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/native.roku.txt"
            "https://v.firebog.net/hosts/RPiList-Malware.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/tif.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/fake.txt"
          ];
        };
      };
    };

    networking.firewall.allowedUDPPorts = [ 53 ];
    networking.firewall.allowedTCPPorts = [ ];
  };
}
