{
  config,
  lib,
  osConfig,
  ...
}:

lib.mkIf osConfig.my.roles.vpn {
  # compose starts only the services whose profile is a location of this host
  home.sessionVariables.COMPOSE_PROFILES = lib.concatStringsSep "," osConfig.my.vpn.locations;

  # The compose stack lives in config/gluetun/ (live link, editable without a
  # switch). The per-device wireguard confs live in
  # ~/.config/gluetun/wireguard (see darwin-module.nix, `just vpn-key`), which
  # compose mounts via ${HOME}; this link lives beside it, not inside it.
  home.file.".config/gluetun-stack".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.my.repoPath}/config/gluetun";
}
