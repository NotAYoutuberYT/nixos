{ config, lib, ... }:

let
  homeDirectory = directory: "${config.home.homeDirectory}/${directory}";
in
{
  options.specialConfig.xdg.enable = lib.mkEnableOption "xdg";

  config = {
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
  };
}
