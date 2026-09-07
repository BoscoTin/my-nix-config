{ 
  pkgs,
  inputs,
  ...
}: 

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.agenix.overlays.default

    # pkgs.unstable.<pkg> — nixos-unstable, for packages not yet good on stable
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];
}