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

    extensions = with pkgs.vscode-extensions; [
      hashicorp.terraform
      eamodio.gitlens
      jnoortheen.nix-ide
      golang.go
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.editor.wrapTabs" = true;
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.fontFamily" = "'MesloLGS NF', 'Source Code Pro', 'FiraCode Nerd Font Mono'";
      "terminal.integrated.scrollback" = 50000;
      "terminal.integrated.persistentSessionScrollback" = 0;

      # Apply when want to switch one dark pro
      # "workbench.colorTheme" = "One Dark Pro Darker";
      # "oneDarkPro.bold" = true;
    };
  };
}