{ osConfig, ... }:

let
  ocfg = osConfig.specialConfig;
in
{
  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = ocfg.zsh.enable or false;
    enableFishIntegration = ocfg.fish.enable or false;
    enableNushellIntegration = ocfg.nushell.enable or false;
  };
}
