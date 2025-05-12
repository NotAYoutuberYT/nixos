{ customModules, ... }:

customModules.withEnableOption {
  programs.firefox.enable = true;
}
