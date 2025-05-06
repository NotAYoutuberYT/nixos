{ customModules, name }:
{ osConfig, pkgs, ... }:

customModules.ifEnabledInNixos { inherit name osConfig; } {
  programs.nushell = {
    enable = true;

    #plugins = with pkgs.nushellPlugins; [
    #  units
    #  skim
    #  query
    #  polars
    #  net
    #  highlight
    #  gstat
    #  formats
    #  dbus
    #];

    settings = {
      buffer_editor = "codium --wait";

      show_banner = false;

      history = {
        format = "sqlite";
        max_size = 1000;
        sync_on_enter = true;
      };
    };
  };
}
