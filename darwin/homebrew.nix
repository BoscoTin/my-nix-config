{ lib, vars, ... }:

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
      "brave-browser"
      "arc"

      # utils
      "shottr"
      "jordanbaird-ice"
      "raycast"

      # dev
      "docker"
    ] ++ lib.optionals (vars.isCasualProfile == true) [
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