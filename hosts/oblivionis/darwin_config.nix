{
  lib,
  inputs,
  vars,
  ...
}:

{
  services.karabiner-elements.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.persistent-apps = [
    "/System/Applications/Launchpad.app/"
    "/System/Applications/iPhone Mirroring.app"
    "/Applications/Discord.app/"
    "/Applications/Telegram.app/"
    "/Applications/Signal.app/"
    "/Applications/Ghostty.app/"
    "/Applications/Arc.app/"
    "/Users/${vars.username}/Applications/Home Manager Apps/Visual Studio Code.app"
  ];

  homebrew.casks = [
    "ghostty" # if pkgs.ghostty works, removes
    "floorp"
    "discord"
    "telegram"
    "signal"
    "motrix"
    "surfshark"
  ];
}