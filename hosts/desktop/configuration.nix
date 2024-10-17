{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixosConfig = {
    bundles.system.enable = true;
    bundles.desktop.enable = true;
    bundles.development.enable = true;
    bundles.home-manager.enable = true;
    nvidia.enable = true;
    piper.enable = true;

    shell = pkgs.zsh;

    homeConfigModule = ./home.nix;
  };

  programs.zsh.enable = true;
  boot.loader.grub.useOSProber = true;

  system.name = "desktop";
  networking.hostName = "desktop";
}
