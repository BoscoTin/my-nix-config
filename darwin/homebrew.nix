{ ... }:

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

      # system extensions
      "audio-hijack"
      "loopback"
      "lulu"

      # chat
      "discord"
      "telegram"

      # others
      "motrix"
      "alfred"
      "anytype"
      "shottr"
    ];
  };
}