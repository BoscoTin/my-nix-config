# Builds a nix-darwin system for one host.
#
#   mkHost { hostname = "oblivionis"; system = "aarch64-darwin"; }
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
}:

inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  specialArgs = { inherit inputs vars; };

  modules =
    [
      ../hosts/${hostname}.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.users.${vars.username}.imports =
          [ ../profiles/hm.nix ] ++ moduleGroup.home;
      }
    ]
    ++ moduleGroup.darwin;
}
