# Directory for the Surfshark WireGuard confs. The confs hold a per-device
# private key, so nix never creates or stores them: provision each with
# `just vpn-key <loc>`. This only makes the directory writable by the user and
# warns about locations that have no conf yet (the build never fails on it).
{
  config,
  lib,
  vars,
  ...
}:

let
  cfg = config.my;
  user = vars.username;
  dir = "/Users/${user}/.config/gluetun/wireguard";
in
{
  assertions = [
    {
      assertion = !cfg.roles.vpn || cfg.vpn.locations != [ ];
      message = "my.roles.vpn needs at least one entry in my.vpn.locations.";
    }
  ];

  system.activationScripts.postActivation.text = lib.mkIf cfg.roles.vpn ''
    # An earlier agenix setup left these root-owned.
    mkdir -p ${dir}
    chown ${user}:staff /Users/${user}/.config/gluetun ${dir}
    chmod 0700 ${dir}
    ${lib.concatMapStringsSep "\n" (loc: ''
      [ -f ${dir}/${loc}.conf ] || echo "warning: no gluetun conf for ${loc}; run 'just vpn-key ${loc}'" >&2
    '') cfg.vpn.locations}
  '';
}
