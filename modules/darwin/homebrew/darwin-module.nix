{ lib, ... }:

{
  homebrew = {
    enable = true;

    # keep `switch` fast and predictable — update/upgrade casks by hand
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };

    casks = [
      "openvanilla"
      "arc"
      "shottr"
      "raycast"
      "docker"
      "ghostty" # nixpkgs ghostty is linux-only; app comes from here (see modules/terminal/ghostty)
    ];
  };
}