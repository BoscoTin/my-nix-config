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
      teleport_15
      k9s
      stern
      terraform
      d2
      jq
    ]
  ) ++ lib.optionals (vars.system != "x86_64-darwin") (
    with pkgs; [
      git-trim
    ]
  );
}