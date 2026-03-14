{
  lib,
  inputs,
  vars,
  ...
}:

{
  services.karabiner-elements.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.persistent-apps = [
    # tahoe no longer has launch pad...
    # "/System/Applications/Launchpad.app/"
    "/Applications/Discord.app/"
    "/Applications/Telegram.app/"
    "/Applications/Signal.app/"
    "/System/Applications/Notes.app/"
    "/Applications/Arc.app/"
    "/Users/${vars.username}/Applications/Home Manager Apps/Visual Studio Code.app"
  ];

  homebrew.casks = [
    "floorp"
    "discord"
    "telegram"
    "signal"
    "motrix"
    "surfshark"
  ];
}