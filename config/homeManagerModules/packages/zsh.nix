{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

{
  config = lib.mkIf (osConfig.specialConfig.shell == pkgs.zsh) {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      syntaxHighlighting.enable = true;

      autosuggestion.enable = true;

      history = {
        size = 1000;
        path = "${config.xdg.dataHome}/.zsh/history";

        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
      };

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        cat = "${pkgs.bat}/bin/bat";
      };
    };
  };
}
