{ pkgs, ... }:

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

    shell = pkgs.zsh;

    homeConfigModule = ./home.nix;
  };

  programs.zsh.enable = true;

  system.name = "envy";
  networking.hostName = "envy";
}
