{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixosConfig = {
    bundles.system.enable = true;
    bundles.desktop.enable = true;
    bundles.home-manager.enable = true;
    nvidia.enable = true;

    piper.enable = true;

    userConfig = "${./home.nix}";
  };

  system.name = "desktop-nixos";
}
