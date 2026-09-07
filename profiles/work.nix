# Work machine profile (managed device: no karabiner, etc.).
{ ... }:

{
  imports = [ ./base.nix ];

  my.profile = "work";

  # work machine: every repo commits as the work identity (no personal default)
  my.git.includePath = "~/.config/git/10-work";

  my.roles = {
    kubernetes = true;
    cloud = true;
    node = true;
    go = true;
  };
}
