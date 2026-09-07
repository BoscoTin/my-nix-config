# `my.*` — the config's own option namespace.
#
# System-level (nix-darwin) options. Home-manager modules read these via
# `osConfig.my.*`. Options are added here as the phase that consumes them lands.
{ lib, ... }:

{
  options.my = {
    profile = lib.mkOption {
      type = lib.types.enum [ "casual" "work" ];
      description = "Which profile this host follows. Set by profiles/<name>.nix.";
    };

    roles = {
      kubernetes = lib.mkEnableOption "kubernetes CLIs (kubectl, kubectx, k9s, stern, ctop)";
      cloud = lib.mkEnableOption "cloud CLIs (awscli2)";
      node = lib.mkEnableOption "node toolchain (fnm)";
      go = lib.mkEnableOption "go toolchain (programs.go, golangci-lint)";
    };

    git.includePath = lib.mkOption {
      type = lib.types.str;
      default = "~/.config/git/00-local";
      description = ''
        Path git unconditionally includes for identity. Casual keeps the
        default (an [includeIf] dispatch that only swaps identity for work
        repos); work points it straight at the work identity so every repo
        commits as work.
      '';
    };
  };
}
