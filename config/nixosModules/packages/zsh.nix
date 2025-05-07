{ customModules, name }:
{ config, pkgs, ... }:

customModules.withNixosEnableOption
  {
    inherit name config;
    enable = config.nixosConfig.shell == pkgs.zsh;
  }
  {
    programs.zsh.enable = true;
  }
