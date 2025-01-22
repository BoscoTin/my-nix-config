{
  pkgs,
  ...
}:

{
  programs.vscode.enableUpdateCheck = true;

  programs.vscode.userSettings = {
    "editor.accessibilitySupport" = "off";
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
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[go]" = {
      "editor.defaultFormatter" = "golang.go";
    };
    "[terraform]" = {
      "editor.defaultFormatter" = "hashicorp.terraform";
    };
  };
}