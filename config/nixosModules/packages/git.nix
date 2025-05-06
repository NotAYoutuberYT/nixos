{ customModules, name }:
{ config, pkgs, ... }:

customModules.withNixosEnableOption { inherit name config; } {
  environment.systemPackages = [
    pkgs.git
    pkgs.gh
  ];
}
