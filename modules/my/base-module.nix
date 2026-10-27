# `my.*` — the config's own option namespace.
#
# System-level (nix-darwin) options. Home-manager modules read these via
# `osConfig.my.*`. Options are added here as the phase that consumes them lands.
{ lib, vars, ... }:

let
  # named git profiles; one pair of agenix blobs each (see secrets/README.md)
  profileType = lib.types.enum [
    "personal"
    "sl"
  ];
in
{
  options.my = {
    profile = lib.mkOption {
      type = lib.types.enum [ "casual" "work" ];
      description = "Which profile this host follows. Set by profiles/<name>.nix.";
    };

    repoPath = lib.mkOption {
      type = lib.types.str;
      default = "/Users/${vars.username}/Projects/my-nix-config";
      description = "Absolute path to this repo's working tree, for out-of-store symlinks.";
    };

    roles = {
      kubernetes = lib.mkEnableOption "kubernetes CLIs (kubectl, kubectx, k9s, stern, ctop)";
      cloud = lib.mkEnableOption "cloud CLIs (awscli2)";
      node = lib.mkEnableOption "node toolchain (fnm)";
      go = lib.mkEnableOption "go toolchain (programs.go, golangci-lint)";
      vpn = lib.mkEnableOption "gluetun (Surfshark) proxy stack and ~/.config/gluetun";
    };

    vpn.locations = lib.mkOption {
      type = lib.types.listOf (lib.types.enum [ "tw" "jp" ]);
      default = [ ];
      description = ''
        Surfshark static-IP locations this host runs a gluetun container for.
        The WireGuard .conf for each lives at
        ~/.config/gluetun/wireguard/<location>.conf, installed per device with
        `just vpn-key <location>` (never stored in the repo). Only used when
        `my.roles.vpn` is enabled.
      '';
    };

    git = {
      mainProfile = lib.mkOption {
        type = profileType;
        description = ''
          Git profile whose identity (user, email, ssh key) applies to every
          repo on this host. Included unconditionally; its `.conditions` blob is
          never wired up.
        '';
      };

      includeProfiles = lib.mkOption {
        type = lib.types.listOf profileType;
        default = [ ];
        description = ''
          Extra git profiles whose `.conditions` (remote-URL `includeIf` rules)
          override the main identity for matching repos. Must not contain
          `mainProfile`.
        '';
      };
    };
  };
}
