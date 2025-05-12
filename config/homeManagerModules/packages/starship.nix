{
  customModules,
  osConfig,
  config,
  lib,
  ...
}:

let
  ocfg = osConfig.nixosConfig;
in
customModules.ifEnabledInNixos {
  programs.starship = with config.colorScheme.palette; {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = ocfg.zsh.enable or false;
    enableFishIntegration = ocfg.fish.enable or false;
    enableNushellIntegration = ocfg.nushell.enable or false;

    settings = {
      add_newline = false;
      scan_timeout = 10;

      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_state"
        "$rust"
        "$nix_shell"
        "$character"
      ];

      directory.style = "bold #${base0D}";
      git_branch.style = "bold #${base0E}";
      git_state.style = "bold #${base0A}";
      rust.style = "bold #${base08}";

      nix_shell = {
        style = "bold #${base0C}";
        format = "via [$symbol]($style) ";
        symbol = "❄️";
      };

      character = {
        success_symbol = "[➜](bold #${base0B})";
        error_symbol = "[➜](bold #${base08})";
      };
    };
  };
}
