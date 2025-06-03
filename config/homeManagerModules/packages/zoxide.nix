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
  options.specialConfig.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf config.specialConfig.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = ocfg.zsh.enable or false;
      enableFishIntegration = ocfg.fish.enable or false;
      enableNushellIntegration = ocfg.nushell.enable or false;
      options = [
        "--cmd cd"
      ];
    };
  };
}
