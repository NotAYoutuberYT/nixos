{ ... }:

{
  disko.devices = {
    disk.disk1 = {
      device = "/dev/sda";
      type = "disk";

      content = {
        type = "gpt";

        partitions = {
          boot = {
            name = "boot";
            type = "EF02";
            size = "1M";
          };

          ESP = {
            name = "ESP";
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
