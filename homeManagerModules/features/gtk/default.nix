{
  config,
  inputs,
  pkgs,
  ...
}:

let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
{
  gtk.enable = true;

  gtk.theme = {
    name = "${config.colorScheme.slug}";
    package = nix-colors-lib.gtkThemeFromScheme {
      scheme = config.colorScheme;
    };
  };
}