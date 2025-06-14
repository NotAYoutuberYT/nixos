{ lib, config, ... }:

{
  options.specialConfig.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf config.specialConfig.git.enable {
    programs.gh.enable = true;

    programs.git = {
      enable = true;

      userName = "bryce";
      userEmail = "utbryceh@gmail.com";

      aliases = {
        aa = "add -A";
        lo = "log --oneline";
        cm = "commit -m";
      };

      extraConfig = {
        core = {
          editor = "codium --wait";
        };

        init = {
          defaultbranch = "main";
        };

        pull = {
          rebase = true;
        };
      };
    };
  };
}
