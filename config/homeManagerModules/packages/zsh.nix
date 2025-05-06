{ customModules, name }:
{
  lib,
  config,
  osConfig,
  pkgs,
  inputs,
  ...
}:

let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
customModules.ifEnabledInNixos { inherit name osConfig; } {
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

      ignorePatterns = [
        "clear"
        "ls"
      ];
    };

    initContent = lib.concatStringsSep "\n" [
      "${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}"
    ];
  };
}
