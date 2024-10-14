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
    programs.zsh = with config.colorScheme.palette; {
      enable = true;

      enableCompletion = true;
      syntaxHighlighting.enable = true;

      autosuggestion = {
        enable = true;
        highlight = "fg=#${base04},bold";
      };

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

    programs.starship = with config.colorScheme.palette; {
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

    programs.zoxide = lib.mkIf cfg.zoxide {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
