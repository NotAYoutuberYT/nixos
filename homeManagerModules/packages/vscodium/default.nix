{
  pkgs,
  inputs,
  config,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      vscode-icons-team.vscode-icons
      bbenoist.nix
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      james-yu.latex-workshop
      tintedtheming.base16-tinted-themes
    ];

    userSettings = {
      "workbench.iconTheme" = "vscode-icons";
      "editor.fontFamily" = "JetBrainsMono NF";
      "files.autoSave" = "afterDelay";
      "[nix]"."editor.tabSize" = 2;

      "terminal.integrated.enablePersistentSessions" = false;
      "terminal.integrated.enableImages" = true;
      "terminal.integrated.customGlyphs" = true;
      "terminal.integrated.gpuAcceleration" = "on";

      "vsicons.dontShowNewVersionMessage" = true;

      "workbench.colorTheme" = "base16-${config.homeManagerConfig.colorScheme}";
    };
  };
}
