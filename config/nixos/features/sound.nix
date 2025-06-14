{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.sound = {
    enable = lib.mkEnableOption "sound";
    jack = lib.mkEnableOption "pipewire jack emulation";
  };

  config = lib.mkIf config.specialConfig.sound.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = config.specialConfig.sound.jack;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
