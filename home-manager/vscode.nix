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
      "workbench.colorTheme" = "One Dark Pro Darker";
      "terminal.integrated.fontFamily" = "'MesloLGS NF', 'Source Code Pro', 'FiraCode Nerd Font Mono'";
    };
  };
}