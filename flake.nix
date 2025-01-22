{
  description = "personal config based on nixpkgs & home manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs @ { 
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }: let
      vars = {
        hmUsername = "bosco";
        defaultGitUsername = "bosco";
        defaultGitMail = "boscotang98@gmail.com";
      };

      modules = import ./all-modules.nix { inherit (nixpkgs) lib; };

      specialArgs = { inherit inputs vars modules; };

      # TODO: not apply overlay here
      overlays = [
        ({ pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
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
        })
      ];
    in {
      darwinConfigurations = {
        mortis = nix-darwin.lib.darwinSystem {
          inherit specialArgs;
          system = "x86_64-darwin";
          modules = [
            ./hosts/mortis
            home-manager.darwinModules.home-manager
          ] ++ modules.darwin
            ++ overlays;
        };
      };
    };
}
