{ config, ... }:

{
  xdg.userDirs = {
    download = "${config.home.homeDirectory}/downloads";
    documents = "${config.home.homeDirectory}/documents";
  };
}
