{
  pkgs,
  vars,
  ...
}:

{
  system.defaults.dock = {
    autohide = false;
    tilesize = 20;
    magnification = true;
    largesize = 48;
    mru-spaces = false;
    show-recents = false;
    persistent-others = [
      "/Users/${vars.username}/Downloads"
    ];
  };
}