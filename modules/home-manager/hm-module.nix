{ 
  lib,
  options,
  vars,
  ...
}:

{
  # config = lib.optionalAttrs (lib.hasAttr "home-manager" options) {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${vars.username} = import ./user.nix
  # };
}