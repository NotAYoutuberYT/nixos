{
  config,
  lib,
  options,
  pkgs,
  ...
}:

let
  cfg = config.nixosConfig.networking;
in
{
  options.nixosConfig.networking = {
    gui = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install nm-connection-manager/applet";
    };
  };

  config = {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = false;

    environment.systemPackages = lib.mkIf cfg.gui [
      pkgs.networkmanagerapplet
    ];
  };
}
