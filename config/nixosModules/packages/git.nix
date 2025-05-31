{ pkgs, lib, ... }:

{
  options.specialConfig.git.enable = lib.mkEnableOption "git";

  config = {
    environment.systemPackages = [
      pkgs.git
      pkgs.gh
    ];
  };
}
