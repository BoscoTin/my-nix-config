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

      # chat
      "discord"
      "telegram"

      # others
      "motrix"
      "alfred"
      "anytype"
      "lulu"
      "shottr"
    ];
  };
}