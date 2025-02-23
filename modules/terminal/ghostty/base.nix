{
  lib,
  pkgs,
  config,
  ...
}:

{
  # manage by hm, please only be imported in hm-module
  programs.ghostty = {
    enableBashIntegration = config.programs.bash.enable;
    enableFishIntegration = config.programs.fish.enable;
    enableZshIntegration = config.programs.zsh.enable;

    package = 
        if pkgs.stdenv.isDarwin
        then pkgs.emptyDirectory # pkgs.ghostty is currently broken on darwin
        else pkgs.ghostty;

    installBatSyntax = false;
    
    settings = {
      theme = "catppuccin-macchiato";

      font-family = "MesloLGS NF";
      font-size = 11;

      background-opacity = 0.93;
      # only supported on macOS;
      background-blur-radius = 10;
      scrollback-limit = 20000;
    };
  };
}