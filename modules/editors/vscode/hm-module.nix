{
  lib,
  pkgs,
  vars,
  ...
}:

{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];
}