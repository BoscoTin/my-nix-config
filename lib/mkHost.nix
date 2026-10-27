# Builds a nix-darwin system for one host.
#
#   mkHost { hostname = "oblivionis"; system = "aarch64-darwin"; }
#
# `username` overrides vars.username for hosts whose macOS account differs.
#
# The host file (hosts/<hostname>.nix) imports a profile (profiles/<name>.nix),
# which is where per-profile divergence lives.
{
  inputs,
  vars,
  moduleGroup,
}:

{
  hostname,
  system,
  username ? vars.username,
}:

let
  hostVars = vars // { inherit username; };
in
inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  specialArgs = { inherit inputs; vars = hostVars; };

  modules =
    [
      ../hosts/${hostname}.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.users.${username}.imports =
          [ ../profiles/hm.nix ] ++ moduleGroup.home;
      }
    ]
    ++ moduleGroup.darwin;
}
