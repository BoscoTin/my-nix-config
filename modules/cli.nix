{ pkgs, lib, vars, ... }:

{
  environment.systemPackages = (
    with pkgs; [
      ripgrep
      eza
      fastfetch
      fd
      zip
      ctop
      awscli2
      kubectl
      kubectx

      go
      golangci-lint
      mockgen
    ]
  ) ++ lib.optionals (vars.system != "x86_64-darwin") (
    with pkgs; [
      git-trim
    ]
  );
}