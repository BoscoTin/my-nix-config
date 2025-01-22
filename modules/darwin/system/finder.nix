{
  pkgs,
  vars,
  ...
}:

{
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    ShowPathbar = true;
  };
}