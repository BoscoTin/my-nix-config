# Casual (personal) machine profile.
{ ... }:

{
  imports = [ ./base.nix ];

  my.profile = "casual";
  my.roles = {
    kubernetes = true;
    cloud = true;
    node = true;
    go = true;
  };
}
