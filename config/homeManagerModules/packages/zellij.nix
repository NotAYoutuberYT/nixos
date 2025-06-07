{
  lib,
  config,
  ...
}:

{
  options.specialConfig.zellij.enable = lib.mkEnableOption "zellij";

  config = lib.mkIf config.specialConfig.zellij.enable {
    programs.zellij = {
      enable = true;
      settings = {

      };
    };
  };
}
