{ pkgs, ... }:

{
  imports = [
    ./nix-core.nix
    ./zsh.nix
    # ./browsers/firefox.nix
  ];
}