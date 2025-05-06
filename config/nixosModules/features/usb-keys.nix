{ customModules, name }:
{ config, ... }:

customModules.withNixosEnableOption { inherit config name; } {
  services.pcscd.enable = true;
}
