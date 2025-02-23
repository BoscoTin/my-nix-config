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
    };
}
