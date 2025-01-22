{ 
  config,
  lib,
  ... 
}:

{
  # manage by hm, please only be imported in hm-module
  config = lib.mkIf config.programs.vscode.enable {
    programs.direnv = {
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}