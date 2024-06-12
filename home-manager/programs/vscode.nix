{ 
  lib,
  pkgs,
  vars,
  ...
}:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = false;

    extensions =
      (with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ])
      ++ (with pkgs.vscode-marketplace; [
        hashicorp.terraform
        eamodio.gitlens
        jnoortheen.nix-ide
        golang.go
        zxh404.vscode-proto3
      ])
      ++ lib.optionals (vars.isCasualProfile == true) (
        with pkgs.vscode-marketplace; [
          sourcegraph.cody-ai
        ]
      );

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.editor.wrapTabs" = true;
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.fontFamily" = "'MesloLGS NF', 'Source Code Pro', 'FiraCode Nerd Font Mono'";
      "terminal.integrated.scrollback" = 50000;
      "terminal.integrated.persistentSessionScrollback" = 0;
      "editor.inlineSuggest.suppressSuggestions" = true;
      "editor.wordWrap" = "on";
    };
  };
}