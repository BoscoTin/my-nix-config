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

    # nixpkgs ghostty is linux-only; on darwin the Homebrew cask provides the
    # app and home-manager only manages ~/.config/ghostty/config
    package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;

    settings = {
      # ghostty's bundled theme name (see `ghostty +list-themes`), not the
      # bat/delta "catppuccin-macchiato" slug
      theme = "Catppuccin Macchiato";

      font-family = "MesloLGS NF";
      font-size = 11;

      background-opacity = 0.93;
      # only supported on macOS;
      background-blur-radius = 10;
      scrollback-limit = 20000;
    };
  };
}
