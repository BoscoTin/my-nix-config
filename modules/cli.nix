{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    eza
    neofetch
    fd
    zip
    lz4

    go
    nodejs
    pnpm
    pulumi
  ];
}