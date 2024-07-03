{ pkgs, lib, vars, ... }:

{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [vars.username];
  };

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}