{
  lib,
  inputs,
  vars,
  ...
}:

{
  services.karabiner-elements.enable = false;
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock.orientation = "right";
  system.defaults.dock.persistent-apps = [
    "/System/Applications/System Settings.app/"
    "/System/Applications/Launchpad.app/"
    "/Applications/Ghostty.app/"
    "/System/Applications/Notes.app/"
    "/Applications/Arc.app/"
    "/Users/${vars.username}/Applications/Home Manager Apps/Visual Studio Code.app"
  ];

  homebrew.casks = [
    "firefox"
  ];
}