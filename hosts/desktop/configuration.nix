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
        name = "DP-3";
        resolution.x = 3840;
        resolution.y = 2160;
        refreshRate = 144;
        position.x = 0;
        position.y = 0;
        scale = 1;
      }
      {
        name = "DP-1";
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
