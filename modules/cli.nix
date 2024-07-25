{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    eza
    neofetch
    fd
    zip
    lz4
    ctop

    go
    nodejs
    pnpm
    pulumi
    golangci-lint
  ];
}