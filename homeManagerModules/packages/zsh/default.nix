{ lib, config, ... }:

{
  programs.zsh = {
    enable = true;

    history = {
      size = 5000;
      path = "${config.xdg.dataHome}/.zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "gitfast" ];
    };
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
        "$character"
      ];

      git_branch.symbol = "";

      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
    };

  };
}
