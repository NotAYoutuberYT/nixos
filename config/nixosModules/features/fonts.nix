{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.specialConfig;
in
{
  options.specialConfig = {
    monospaceFont = lib.mkOption {
      default = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono NF";
      };
      description = "system-wide monospace font";
    };

    extraFonts = lib.mkOption {
      default = [
        pkgs.cm_unicode
        pkgs.corefonts
      ];
      description = "extra fonts to install";
    };
  };

  config = {
    fonts.enableDefaultPackages = true;
    fonts.packages = [
      cfg.monospaceFont.package
    ] ++ cfg.extraFonts;
  };
}
