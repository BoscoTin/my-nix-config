# oblivionis — Apple Silicon, casual profile.
{
  vars,
  ...
}:

{
  imports = [ ../profiles/casual.nix ];

  system.primaryUser = vars.username;

  # fix on 25.11 error: Build user group has mismatching GID, aborting activation
  ids.gids.nixbld = 350;

  services.karabiner-elements.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.persistent-apps = [
    # tahoe no longer has launch pad...
    # "/System/Applications/Launchpad.app/"
    "/System/Applications/iPhone Mirroring.app"
    "/Applications/Discord.app/"
    "/Applications/Telegram.app/"
    "/Applications/Signal.app/"
    "/Applications/Ghostty.app/"
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
