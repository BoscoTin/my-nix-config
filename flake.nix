{
  description = "bosco configuration on nix ecosystem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
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
      vars = {
        username = "bosco"; # system username
        useremail = "boscotang98@gmail.com"; # system user email
        isCasualProfile = true; # whether to use work profile or not
      };
    in {
      darwinConfigurations = (
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager darwin vars;
        }
      );
    };
}
