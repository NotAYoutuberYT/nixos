{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  specialConfig = {
    hostHomeConfigModule = ./home.nix;

    bundles.desktop.enable = true;
    bundles.command-line.enable = true;
    stylix.enable = true;

    nvidia.enable = true;

    desktopHardware.monitors = [
      {
        name = "Sony SDMU27M90*30 9519291";
        primary = true;
        resolution.x = 3840;
        resolution.y = 2160;
        refreshRate = 144;
        position.x = 0;
        position.y = 0;
        scale = 1;
      }
      {
        name = "GIGA-BYTE TECHNOLOGY CO. LTD. M27Q 21010B002718";
        primary = false;
        resolution.x = 2560;
        resolution.y = 1440;
        refreshRate = 170;
        position.x = 3840;
        position.y = 0;
        scale = 1;
      }
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.name = "desktop";
  networking.hostName = "desktop";
}
