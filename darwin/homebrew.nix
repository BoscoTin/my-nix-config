{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    }

    casks = [
      # input
      "openvanilla"

      # browsers
      "arc"
      "firefox"
      "brave-browser"

      # system extensions
      "istats-menus"
      "audio-hijack"
      "loopback"
      "shottr"

      "motrix"
      "alfred"
      "lulu"
    ];
  }
}