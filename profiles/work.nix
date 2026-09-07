# Work machine profile (managed device: no karabiner, etc.).
{ ... }:

{
  imports = [ ./base.nix ];

  my.profile = "work";
  my.roles = {
    kubernetes = true;
    cloud = true;
    node = true;
    go = true;
  };
}
