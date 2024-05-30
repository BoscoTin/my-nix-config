{ inputs, nixpkgs, home-manager, darwin, vars, ... }:

let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  specialArgs = { inherit inputs system pkgs vars; };
in
{
  cerulean = darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules = [
      ./system.nix
      ./homebrew.nix
      ../modules

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${vars.username} = import ../home-manager;
      }
    ];
  };
}