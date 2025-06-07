{ osConfig, ... }:

{
  imports = [ ];

  config = {
    home.username = osConfig.specialConfig.username;

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
  };
}
