{ lib, config, osConfig, ... }:

{
  options.specialConfig.zellij.enable = lib.mkEnableOption "zellij";

  config = lib.mkIf config.specialConfig.zellij.enable {
    programs.zellij = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = osConfig.specialConfig.zsh.enable or false;
      enableFishIntegration = osConfig.specialConfig.fish.enable or false;

      settings = {

      };
    };
  };
}
