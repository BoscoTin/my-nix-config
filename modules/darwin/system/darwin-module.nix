{
  pkgs,
  vars,
  ...
}:

{
  imports = [
    ./dock.nix
    ./sys_defaults.nix
    ./finder.nix
    ./controlcenter.nix
    ./keyboard.nix
  ];
}