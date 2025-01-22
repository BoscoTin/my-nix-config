{ 
  lib,
  options,
  inputs,
  vars,
  ...
}:

{
  config = lib.optionalAttrs (lib.hasAttr "home-manager" options) {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs vars; };
  };
}