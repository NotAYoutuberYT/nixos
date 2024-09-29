{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    bundles.system.enable = true;
    bundles.desktop.enable = true;
    bundles.home-manager.enable = true;
    networking = {
      enable = true;
      gui = true;
    };

    userConfig = "${./home.nix}";
  };

  system.name = "portable-nixos";
}
