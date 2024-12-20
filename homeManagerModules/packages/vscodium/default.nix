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
    mutableExtensionsDir = false;

    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      vscode-icons-team.vscode-icons
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      james-yu.latex-workshop
      tintedtheming.base16-tinted-themes
      bradlc.vscode-tailwindcss
      dioxuslabs.dioxus
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

      "workbench.colorTheme" = "base16-${config.colorScheme.slug}";

      "tailwindCSS.experimental.classRegex" = [ "class\\s*:\\s*\"([^\"]*)" ];
      "tailwindCSS.includeLanguages" = {
        "rust" = "html";
      };

      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [
              "nix"
              "fmt"
              "--"
              "-"
            ];
          };

          "nixpkgs" = {
            "expr" = "import <nixpkgs> { }";
          };

          "nixos" = {
            # the exact system pinned to isn't relevant, what's shown below is just a setup I know
            # will always be active, available, and as up to date as I need
            "expr" = "(builtins.getFlake \"github:NotAYoutuberYT/nixos\").nixosConfigurations.desktop.options";
          };
        };
      };
    };
  };
}
