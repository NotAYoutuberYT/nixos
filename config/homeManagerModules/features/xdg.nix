{ customModules, name }:
{ config, ... }:

let
  homeDirectory = directory: "${config.home.homeDirectory}/${directory}";
in
customModules.withHomeManagerEnableOption { inherit name config; } {
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;

    desktop = homeDirectory "desktop";
    documents = homeDirectory "documents";
    download = homeDirectory "downloads";
    music = homeDirectory "music";
    pictures = homeDirectory "pictures";
    templates = homeDirectory "templates";
    videos = homeDirectory "videos";
  };
}
