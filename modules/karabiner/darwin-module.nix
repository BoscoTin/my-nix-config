{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.xdg.enable && config.services.karabiner-elements.enable && pkgs.stdenv.isDarwin) {
    home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
  };
}