{ lib, ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    # only add tools only available in casks here
    casks = [
      # input
      "openvanilla"

      # browsers
      "firefox"
      "arc"

      # utils
      "shottr"
      "raycast"

      # dev
      "docker"

      # chat
      "discord"
      "telegram"
      "signal"

      # others
      "motrix"
      "surfshark"
    ];
  };
}