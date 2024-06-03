{ inputs, nixpkgs, home-manager, darwin, vars, ... }:

let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };
  specialArgs = { inherit inputs system pkgs vars; };
in
{
  ${vars.hostProfile} = darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules = [
      ./nix-core.nix
      ./system.nix
      ./homebrew.nix

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