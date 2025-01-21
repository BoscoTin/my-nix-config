{ 
  pkgs, 
  lib, 
  ... 
}:

{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 30d";
    };
  };

  services.nix-daemon.enable = true;
}