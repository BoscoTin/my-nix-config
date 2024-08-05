{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    eza
    fastfetch
    fd
    zip
    ctop
    kubectl
    kubectx
    git-trim

    go
    golangci-lint
    mockgen
  ];
}