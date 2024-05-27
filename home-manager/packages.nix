{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    go
    wget
  ];
}