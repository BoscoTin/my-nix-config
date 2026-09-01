{
  description = "personal config based on nixpkgs & home manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs @ { 
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }: let
      vars = {
        username = "bosco";
        defaultGitUsername = "bosco";
        defaultGitMail = "boscotang98@gmail.com";
        device = "mb";
      };

      moduleGroup = import ./all-modules.nix { inherit (nixpkgs) lib; };

      specialArgs = { inherit vars; };

      systems = [ "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      darwinConfigurations = {
        mortis = nix-darwin.lib.darwinSystem {
          inherit inputs specialArgs;
          system = "x86_64-darwin";
          modules = [
            ./hosts/mortis
            home-manager.darwinModules.home-manager
          ] ++ moduleGroup.darwin;
        };

        doloris = nix-darwin.lib.darwinSystem {
          inherit inputs specialArgs;
          system = "aarch64-darwin";
          modules = [
            ./hosts/doloris
            home-manager.darwinModules.home-manager
          ] ++ moduleGroup.darwin;
        };

        oblivionis = nix-darwin.lib.darwinSystem {
          inherit inputs specialArgs;
          system = "aarch64-darwin";
          modules = [
            ./hosts/oblivionis
            home-manager.darwinModules.home-manager
          ] ++ moduleGroup.darwin;
        };
      };

      hmModules = moduleGroup.home;

      # `nix run .#just` — pinned to this flake's nixpkgs, so the workflow
      # bootstraps on a machine that has no `just` yet.
      packages = forAllSystems (system: {
        just = nixpkgs.legacyPackages.${system}.just;
      });

      # `nix flake check` / `just check` builds each host's system closure.
      checks = {
        aarch64-darwin = {
          oblivionis = self.darwinConfigurations.oblivionis.system;
          doloris = self.darwinConfigurations.doloris.system;
        };
        x86_64-darwin = {
          mortis = self.darwinConfigurations.mortis.system;
        };
      };
    };
}
