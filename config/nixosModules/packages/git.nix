{ customModules, pkgs, ... }:

customModules.withEnableOption {
  environment.systemPackages = [
    pkgs.git
    pkgs.gh
  ];
}
