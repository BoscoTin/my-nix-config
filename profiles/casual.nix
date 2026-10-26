# Casual (personal) machine profile.
{ ... }:

{
  imports = [ ./base.nix ];

  my.profile = "casual";
  my.git = {
    mainProfile = "personal";
    includeProfiles = [ "sl" ];
  };
  my.roles = {
    kubernetes = true;
    cloud = true;
    node = true;
    go = true;
  };

  homebrew.casks = [
    "zen"
    "discord"
    "telegram"
    "signal"
    "motrix"
    "surfshark" # casual only (gluetun is a proxy, not system-wide)
  ];
}
