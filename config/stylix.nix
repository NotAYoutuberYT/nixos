{
  pkgs,
  lib,
  config,
  ...
}:

let
  base-wallpaper = config.specialConfig.stylix.base-wallpaper;

  jsonTheme = pkgs.writers.writeJSON "theme.json" {
    name = "nixTheme";
    colors = with config.lib.stylix.colors.withHashtag; [
      base00
      base01
      base02
      base03
      base04
      base05
      base06
      base07
      base08
      base09
      base0A
      base0B
      base0C
      base0D
      base0E
      base0F
    ];
  };

  tinted-wallpaper =
    if config.specialConfig.stylix.tint-wallpaper then
      pkgs.runCommand "wallpaper.png" { } ''
        export HOME=$(${lib.getExe pkgs.mktemp} -d)
        ${lib.getExe pkgs.gowall} convert ${base-wallpaper} -t ${jsonTheme} --output $out
      ''
    else
      base-wallpaper;
in
{
  options.specialConfig.stylix = {
    enable = lib.mkEnableOption "stylix theming";

    # realistically, these options should never change, but this
    # is the most logical spot to put these things
    theme = lib.mkOption {
      default = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";
    };

    base-wallpaper = lib.mkOption {
      default = ./../wallpapers/nasa.png;
    };

    tint-wallpaper = lib.mkEnableOption "wallpaper tinting" // {
      default = true;
    };
  };

  config.stylix = lib.mkIf config.specialConfig.stylix.enable {
    enable = true;

    base16Scheme = config.specialConfig.stylix.theme;
    image = tinted-wallpaper;

    cursor = {
      name = "rose-pine-hyprcursor";
      package = pkgs.rose-pine-hyprcursor;
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes.terminal = 11.25;
    };
  };
}
