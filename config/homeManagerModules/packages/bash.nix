{ ... }:

{
  programs.bash = {
    enable = true;

    enableCompletion = true;

    historyControl = [
      "erasedups"
      "ignorespace"
    ];
    historyIgnore = [
      "clear"
      "ls"
      "exit"
    ];
    historySize = 50;
    historyFileSize = 1000;
  };
}
