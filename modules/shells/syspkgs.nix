{
  config,
  lib,
  pkgs,
  ...
}:

let
  roles = config.my.roles;
in
{
  # Packages that fail to build on a platform get an explicit gate here, e.g.
  #   ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 (with pkgs; [ pkg ])
  # (none currently — both hosts are aarch64-darwin)
  environment.systemPackages =
    (with pkgs; [
      # universal CLI
      fastfetch
      zip
      ripgrep
      eza
      jq
      fd
      git-trim

      # flake workflow (see justfile)
      just
      nvd

      # secrets: agenix edits blobs, age provides age-keygen
      agenix
      age
    ])
    ++ lib.optionals roles.kubernetes (with pkgs; [
      ctop
      kubectl
      kubectx
      k9s
      stern
    ])
    ++ lib.optionals roles.cloud (with pkgs; [
      awscli2
    ])
    ++ lib.optionals roles.node (with pkgs; [
      fnm
    ])
    ++ lib.optionals roles.go (with pkgs; [
      golangci-lint
    ]);
}
