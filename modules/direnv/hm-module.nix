{ 
  config,
  lib,
  ... 
}:

{
  config = lib.mkIf config.programs.direnv.enable {
    programs.direnv = {
      enableZshIntegration = config.programs.zsh.enable;
      nix-direnv.enable = true;
    };
  };
}