{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    eza
    neofetch
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