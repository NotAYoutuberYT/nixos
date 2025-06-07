{
  config,
  osConfig,
  lib,
  ...
}:

let
  ocfg = osConfig.specialConfig;
in
{
  options.specialConfig.starship.enable = lib.mkEnableOption "starship";

  config = lib.mkIf config.specialConfig.starship.enable {
    programs.starship = {
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
          "$nix_shell"
          "$character"
        ];

        directory.style = "bold blue";
        git_branch.style = "bold magenta";
        git_state.style = "bold orange";

        nix_shell = {
          style = "bold cyan";
          format = "via [$symbol]($style) ";
          symbol = "❄️";
        };

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
