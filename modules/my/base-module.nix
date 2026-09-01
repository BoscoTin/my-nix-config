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
  };
}
