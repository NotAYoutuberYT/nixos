{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
{
  options.specialConfig.gtk.enable = lib.mkEnableOption "gtk";

  config = {
    gtk.enable = true;

    gtk.theme = {
      name = "${config.colorScheme.slug}";
      package = nix-colors-lib.gtkThemeFromScheme {
        scheme = config.colorScheme;
      };
    };
  };
}
