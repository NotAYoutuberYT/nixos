{ customModules, name }:
{ config, ... }:

customModules.withNixosEnableOption { inherit name config; } {
  programs.thunar.enable = true;
}
