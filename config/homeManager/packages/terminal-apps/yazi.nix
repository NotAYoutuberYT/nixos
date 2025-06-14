{
  lib,
  config,
  osConfig,
  ...
}:

let
  ocfg = osConfig.specialConfig;
in
{
  options.specialConfig.yazi.enable = lib.mkEnableOption "yazi";

  config = lib.mkIf config.specialConfig.yazi.enable {
    programs.yazi = {
      enable = true;

      enableZshIntegration = ocfg.zsh.enable or false;
      enableFishIntegration = ocfg.fish.enable or false;
      enableNushellIntegration = ocfg.nushell.enable or false;
    };
  };
}
