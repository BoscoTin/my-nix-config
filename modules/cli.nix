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
    git-trim

    go
    golangci-lint
    mockgen
  ];
}