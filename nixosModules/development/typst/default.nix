{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    typst
    typstfmt
    typst-lsp
  ];
}
