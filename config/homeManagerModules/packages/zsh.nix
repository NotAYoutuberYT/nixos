{
  customModules,
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
customModules.ifEnabledInNixos {
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

    initContent = lib.concatStringsSep "\n" [
      "${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}"
    ];
  };
}
