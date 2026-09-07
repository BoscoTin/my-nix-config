{
  description = "personal config based on nixpkgs & home manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
      vars = {
        username = "bosco";
        defaultGitUsername = "bosco";
        defaultGitMail = "boscotang98@gmail.com";
        device = "mb";
      };

      moduleGroup = import ./all-modules.nix { inherit (nixpkgs) lib; };
      mkHost = import ./lib/mkHost.nix { inherit inputs vars moduleGroup; };

      systems = [ "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      darwinConfigurations = {
        oblivionis = mkHost { hostname = "oblivionis"; system = "aarch64-darwin"; };
        doloris = mkHost { hostname = "doloris"; system = "aarch64-darwin"; };
      };

      # `nix run .#just` — pinned to this flake's nixpkgs, so the workflow
      # bootstraps on a machine that has no `just` yet.
      packages = forAllSystems (system: {
        just = nixpkgs.legacyPackages.${system}.just;
      });

      # `nix flake check` / `just check` builds each host's system closure.
      checks.aarch64-darwin = {
        oblivionis = self.darwinConfigurations.oblivionis.system;
        doloris = self.darwinConfigurations.doloris.system;
      };
    };
}
