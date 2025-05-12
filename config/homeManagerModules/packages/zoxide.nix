{ customModules, osConfig, ... }:

let
  ocfg = osConfig.nixosConfig;
in
customModules.ifEnabledInNixos {
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
}
