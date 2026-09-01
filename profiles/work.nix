# Work machine profile (managed device: no karabiner, etc.).
{ ... }:

{
  imports = [ ./base.nix ];

  my.profile = "work";
}
