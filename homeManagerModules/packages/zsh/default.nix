{ lib, config, ... }:

let
  cfg = config.homeManagerConfig.zsh;
in
{
  options.homeManagerConfig.zsh = {
    zoxide = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "zoxide toggle";
    };
  };

  config = {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      shellAliases = {
        ls = "ls --color";
        c = "clear";
      };

      history = {
        size = 1000;
        path = "${config.xdg.dataHome}/.zsh/history";

        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;

        ignorePatterns = [
          "clear"
          "c"
        ];
      };

      initExtra = lib.concatStringsSep "\n" [ ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;

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

        nix_shell = {
          format = "via [$symbol]($style) ";
          symbol = "❄️";
        };

        character = {
          success_symbol = "➜";
          error_symbol = "➜";
        };
      };
    };

    programs.zoxide = lib.mkIf cfg.zoxide {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
