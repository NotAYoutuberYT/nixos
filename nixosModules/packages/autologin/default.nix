{ config, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = config.nixosConfig.username;
      };
      default_session = initial_session;
    };
  };
}
