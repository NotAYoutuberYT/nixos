{ customModules, ... }:

customModules.withEnableOption {
  services.pcscd.enable = true;
}
