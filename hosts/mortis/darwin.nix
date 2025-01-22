{
  lib,
  ...
}:

{
  services.karabiner-elements.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
}