{ lib, inputs, nixpkgs, home-manager, darwin, vars, ... }:

let
  system = vars.system;
  hostPlatform = system;
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
      ../modules/cli.nix

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${vars.username} = import ../modules/home-manager;
      }
    ] ++ lib.optionals (vars.isCasualProfile == true) [
      # work machine ususally banned, see issue https://github.com/pqrs-org/Karabiner-Elements/issues/3760
      ./karabiner.nix
    ];    
  };
}