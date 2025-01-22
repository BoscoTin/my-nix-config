{ 
  lib,
  pkgs,
  vars,
  ...
}:

{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];
  programs.vscode.enable = true;
}