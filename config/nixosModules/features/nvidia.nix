{ customModules, config, ... }:

customModules.withEnableOption {
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
}
