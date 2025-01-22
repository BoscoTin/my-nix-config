{ 
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  # manage by hm, please only be imported in hm-module
  config = lib.mkIf config.programs.vscode.enable {
    imports = [
      ./extensions.nix
      ./settings.nix
    ];
  };
}