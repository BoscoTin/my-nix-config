{
  description = "bosco configuration on nix ecosystem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
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
        gitUsername = "bosco"; # git username, used in default config
        useremail = "boscotang98@gmail.com"; # system user email
        isCasualProfile = true; # whether to use work profile or not
        hostProfile = "cerulean"; # profile name, keep same with makefile
        deviceName = "mba"; # used in localHostName / hostName
        system = "aarch64-darwin";
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
