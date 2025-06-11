{ lib, config, ... }:

{
  options.specialConfig.services.blocky = {
    enable = lib.mkEnableOption "blocky";
    
    upstream-dns = lib.mkOption {
      default = [
        "tcp-tls:9.9.9.9"
        "tcp-tls:194.242.2.4"
        "tcp-tls:193.110.81.0"
      ];
    };
  };

  config = lib.mkIf config.specialConfig.services.blocky.enable {
    services.blocky = {
      enable = true;

      settings = {
        upstreams.groups."default" = config.specialConfig.services.blocky.upsteam-dns;

        ports.dns = 53;
        ports.https = 3002;

        log.level = "critical";
        log.privacy = true;

        caching.minTime = "5m";
        caching.maxTime = "60m";

        blocking.denylists = {
          "default" = [
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

    # TODO: improve network domain modularity
    specialConfig.services.acme.enable = true;
    services.nginx.virtualHosts."blocky.bryceh.com".locations."/" = {
      recommendedProxySettings = true;
      proxyPass = "http://127.0.0.1:${toString config.services.blocky.settings.ports.https}";
    };
  };
}
