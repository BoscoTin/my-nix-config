{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = (
    with pkgs; [
      fastfetch

      zip
      ripgrep
      eza
      jq
      fd

      # consider modularize
      ctop
      kubectl
      kubectx
      teleport
      k9s
      stern
      awscli2
      terraform
      fnm
      golangci-lint
    ]
  ) ++ lib.optionals (pkgs.system != "x86_64-darwin") (
    with pkgs; [
      git-trim
    ]
  );
}