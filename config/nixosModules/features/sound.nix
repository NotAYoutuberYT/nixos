{ customModules, name }:
{ lib, config, ... }:

customModules.withNixosEnableOption { inherit config name; } {
  options.nixosConfig.${name}.jack = lib.mkEnableOption "pipewire jack emulation";

  config = {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = config.nixosConfig.sound.jack;
    };
  };
}
