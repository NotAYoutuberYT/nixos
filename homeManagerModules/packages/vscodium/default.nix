{ pkgs, inputs, ... }:

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
      ecmel.vscode-html-css
    ];
  };
}
