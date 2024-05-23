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
  };
}