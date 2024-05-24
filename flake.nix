{
  description = "bosco configuration on nix ecosystem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { 
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
      username = "bosco"; # system username
      useremail = "boscotang98@gmail.com"; # system user email
      system = "aarch64-darwin"; # follow machine (x86_64-darwin / aarch64-darwin)
      hostname = "cerulean"; # take whatever you want
      specialArgs =
        inputs
        // {
          inherit system username useremail hostname;
        };
    in {
      darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          ./darwin
          ./modules

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${username} = import ./home-manager;
          }
        ];
      };

      # set formatter for ${system}
      formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    };
}
