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
