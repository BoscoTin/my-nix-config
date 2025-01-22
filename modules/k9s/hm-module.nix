{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.xdg.enable {
    home = {
      file.".config/k9s/config.yaml".source = ./config.yaml;
      file.".config/k9s/skins/macchiato.yaml".source = ./macchiato.yaml;
    };
  };
}