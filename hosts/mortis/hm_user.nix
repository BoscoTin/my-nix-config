{
  vars,
  ...
}:

{
  imports = [
    ../base
  ];

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
}
