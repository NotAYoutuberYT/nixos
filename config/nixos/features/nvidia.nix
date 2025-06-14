{ config, lib, ... }:

{
  options.specialConfig.nvidia.enable = lib.mkEnableOption "nvidia";

  config = lib.mkIf config.specialConfig.nvidia.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
