{ pkgs, lib, ... }:

{
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}