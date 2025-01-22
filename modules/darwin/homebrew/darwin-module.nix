{ lib, ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "openvanilla"
      "arc"
      "shottr"
      "raycast"
      "docker"
    ];
  };
}