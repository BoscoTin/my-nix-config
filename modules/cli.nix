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

    go
    golangci-lint
    mockgen
  ];
}