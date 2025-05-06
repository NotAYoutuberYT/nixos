{ customModules, name }:
{
  config,
  inputs,
  pkgs,
  ...
}:

let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
customModules.withHomeManagerEnableOption { inherit name config; } {
  gtk.enable = true;

  gtk.theme = {
    name = "${config.colorScheme.slug}";
    package = nix-colors-lib.gtkThemeFromScheme {
      scheme = config.colorScheme;
    };
  };
}
