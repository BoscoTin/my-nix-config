{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (osConfig.services.karabiner-elements.enable && pkgs.stdenv.isDarwin) {
    home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
  };
}