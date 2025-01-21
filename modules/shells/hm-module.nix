{ pkgs, ... }:

{
  imports = [
    ./syspkgs.nix
    ./zsh.nix
  ];
}