{ pkgs, ... }:

{
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $F'';

      mkdir = ''
        ''${{
          clear
          printf "directory name: "
          read DIR
          mkdir $DIR
        }}
      '';

      touch = ''
        ''${{
          clear
          printf "file name: "
          read FILENAME
          touch $FILENAME
        }}
      '';
    };

    keybindings = {
      o = "dragon-out";

      m = "mkdir";
      t = "touch";
    };

    settings = {
      icons = true;
    };
  };
}
