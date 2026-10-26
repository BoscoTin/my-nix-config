# Work machine profile (managed device: no karabiner, etc.).
{ ... }:

{
  imports = [ ./base.nix ];

  my.profile = "work";

  # work machine: work identity by default, personal identity for personal repos
  my.git = {
    mainProfile = "sl";
    includeProfiles = [ "personal" ];
  };

  my.roles = {
    kubernetes = true;
    cloud = true;
    node = true;
    go = true;
  };

  homebrew.casks = [
    "firefox"
  ];
}
