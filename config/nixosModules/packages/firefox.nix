{ customModules, name }:
{ config, ... }:

customModules.withNixosEnableOption { inherit name config; } {
  programs.firefox.enable = true;
}
