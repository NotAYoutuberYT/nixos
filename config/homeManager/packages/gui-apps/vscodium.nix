{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  options.specialConfig.vscodium.enable = lib.mkEnableOption "vscodium";

  config = lib.mkIf config.specialConfig.vscodium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;

      profiles.default = {
        extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}; [
          open-vsx.vscode-icons-team.vscode-icons
          open-vsx.jnoortheen.nix-ide
          open-vsx.rust-lang.rust-analyzer
          open-vsx.tamasfe.even-better-toml
          open-vsx.james-yu.latex-workshop
          open-vsx.bradlc.vscode-tailwindcss
          open-vsx.myriad-dreamin.tinymist
          open-vsx.gleam.gleam
          vscode-marketplace.dioxuslabs.dioxus
        ];

        userSettings = {
          "workbench.iconTheme" = "vscode-icons";
          "files.autoSave" = "afterDelay";
          "[nix]"."editor.tabSize" = 2;

          "terminal.integrated.enablePersistentSessions" = false;
          "terminal.integrated.enableImages" = true;
          "terminal.integrated.customGlyphs" = true;
          "terminal.integrated.gpuAcceleration" = "on";
          "terminal.integrated.sendKeybindingsToShell" = true;

          "files.autoSaveDelay" = 50;

          "vsicons.dontShowNewVersionMessage" = true;

          "tailwindCSS.experimental.classRegex" = [ "class\\s*:\\s*\"([^\"]*)" ];
          "tailwindCSS.includeLanguages" = {
            "rust" = "html";
          };

          "tinymist.formatterMode" = "typstyle";
          "[typst]" = {
            "editor.formatOnSave" = true;
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
                "expr" =
                  "(builtins.getFlake \"github:NotAYoutuberYT/nixos\").specialConfigurations.desktop.options";
              };
            };
          };
        };
      };
    };
  };
}
