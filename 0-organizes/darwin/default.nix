{ lib, inputs, nixpkgs, home-manager, darwin, vars, ... }:

let
  system = vars.system;
  hostPlatform = system;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      (self: super: {
        karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
          version = "14.13.0";

          src = super.fetchurl {
            inherit (old.src) url;
            hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
          };
        });
      })
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

      # TODO: search these configs how to apply
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