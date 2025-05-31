{ lib, pkgs, ... }:

{
  options.specialConfig.bundles.command-line.enable = lib.mkEnableOption "command-line bundle";

  config = {
    specialConfig.sops.enablePackage = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      zoxide
      starship
      thefuck
      helix
    ];
  };
}
