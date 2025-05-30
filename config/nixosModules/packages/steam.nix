{ customModules, ... }:

customModules.withEnableOption {
  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;

    gamescope.enable = true;
  };
}
