{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf config.specialConfig.git.enable {
    environment.systemPackages = [
      pkgs.git
      pkgs.gh
    ];
  };
}
