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

      # system extensions
      "istats-menus"
      "audio-hijack"
      "loopback"
      "shottr"

      "motrix"
      "alfred"
      "lulu"
    ];
  };
}