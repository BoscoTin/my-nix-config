{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      zhuangtongfa.material-theme
      vscode-icons-team.vscode-icons
      oderwat.indent-rainbow
      hashicorp.terraform
      eamodio.gitlens
      jnoortheen.nix-ide
      golang.go
    ];

    userSettings = {
      # theme
      "workbench.colorTheme" = "One Dark Pro Darker";
      "workbench.editor.wrapTabs" = true;
      "oneDarkPro.bold" = true;
      "editor.semanticHighlighting.enabled" = true;

      # vscode inline terminal settings
      "terminal.integrated.fontFamily" = "'MesloLGS NF', 'Source Code Pro', 'FiraCode Nerd Font Mono'";
    };
  };
}