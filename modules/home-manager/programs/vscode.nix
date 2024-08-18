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
        esbenp.prettier-vscode
      ])
      ++ lib.optionals (vars.isCasualProfile == true) (
        with pkgs.vscode-marketplace; [
          sourcegraph.cody-ai
        ]
      );

    userSettings = {
      "editor.inlineSuggest.suppressSuggestions" = true;
      "editor.semanticHighlighting.enabled" = true;
      "editor.wordWrap" = "on";
      "explorer.confirmDelete" = false;
      "terminal.integrated.fontFamily" = "'MesloLGS NF', 'Source Code Pro', 'FiraCode Nerd Font Mono'";
      "terminal.integrated.persistentSessionScrollback" = 0;
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "terminal.integrated.scrollback" = 50000;
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.editor.wrapTabs" = true;
      "search.exclude" = {
        "**/.direnv" = true;
      };
    };
  };
}